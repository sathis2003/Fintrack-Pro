import 'dart:convert';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class CameraService {
  static Future<String?> captureReceipt() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) return null;
    final picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
      maxWidth: 1920,
      maxHeight: 2560,
      preferredCameraDevice: CameraDevice.rear,
    );
    if (photo == null) return null;

    final bytes = await photo.readAsBytes();
    Uint8List compressed = bytes;
    if (bytes.lengthInBytes > 1024 * 1024) {
      final result = await FlutterImageCompress.compressWithList(
        bytes,
        quality: 70,
        minWidth: 800,
        minHeight: 600,
      );
      compressed = result;
    }
    return base64Encode(compressed);
  }
}
