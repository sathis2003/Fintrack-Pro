import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class GemmaModelService {
  static const _modelUrl =
      'https://huggingface.co/google/gemma-3n-E2B-it-litert-preview/resolve/main/gemma-3n-E2B-it-int4.task';
  static const _prefsKey = 'gemma_model_ready';

  static final downloadProgress = ValueNotifier<double?>(null);
  static final isReady = ValueNotifier<bool>(false);
  static dynamic _activeModel;

  /// Call once after ProfileSetupPage completes.
  static Future<void> startBackgroundDownload() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool(_prefsKey) == true) {
      await _initModel();
      return;
    }

    final connectivity = await Connectivity().checkConnectivity();
    final isWifi = connectivity.contains(ConnectivityResult.wifi);
    if (!isWifi) {
      _waitForWifiThenDownload();
      return;
    }

    await _downloadModel();
  }

  static Future<void> _downloadModel() async {
    try {
      await FlutterGemma.installModel(modelType: ModelType.gemmaIt)
          .fromNetwork(
        _modelUrl,
      )
          .withProgress((progress) {
        // progress might be a class with percentage or just an int
        // based on analyze, it's inferred as int
        downloadProgress.value = (progress as dynamic).percentage / 100.0;
      }).install();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_prefsKey, true);
      downloadProgress.value = 1.0;
      await _initModel();
    } catch (e, stack) {
      downloadProgress.value = null;
      await Sentry.captureException(e,
          stackTrace: stack, hint: Hint.withMap({'context': 'gemma_download'}));
    }
  }

  static Future<void> _initModel() async {
    try {
      _activeModel = await FlutterGemma.getActiveModel(
        maxTokens: 512,
      );
      isReady.value = true;
    } catch (e) {
      isReady.value = false;
      // Re-download if model file is missing but prefs say it's ready
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_prefsKey, false);
    }
  }

  static void _waitForWifiThenDownload() {
    Connectivity().onConnectivityChanged.listen((results) {
      if (results.contains(ConnectivityResult.wifi) &&
          downloadProgress.value == null) {
        _downloadModel();
      }
    });
  }

  static Future<bool> isEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('gemma_enabled') ?? true;
  }

  /// Streaming response from on-device Gemma.
  static Stream<String> generate(String prompt) {
    if (!isReady.value || _activeModel == null) {
      throw GemmaNotReadyException('Gemma model not loaded yet');
    }
    return _activeModel.getResponseAsync(prompt: prompt);
  }

  /// Blocking response — waits for full output.
  static Future<String> generateSync(String prompt) async {
    if (!await isEnabled()) return '';
    if (!isReady.value) return '';
    final buffer = StringBuffer();
    try {
      await for (final token in generate(prompt)) {
        buffer.write(token);
      }
    } catch (e) {
      return 'Error generating response: On-device AI busy or failed.';
    }
    return buffer.toString().trim();
  }

  /// Delete model from device.
  static Future<void> deleteModel() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKey, false);
    await _activeModel?.close();
    _activeModel = null;
    isReady.value = false;
    downloadProgress.value = null;
  }
}

class GemmaNotReadyException implements Exception {
  final String message;
  GemmaNotReadyException(this.message);
  @override
  String toString() => 'GemmaNotReadyException: $message';
}
