import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../core/constants/revenue_cat_constants.dart';

@lazySingleton
class RevenueCatService {
  Future<void> init(String userId) async {
    await Purchases.setLogLevel(kDebugMode ? LogLevel.debug : LogLevel.error);

    PurchasesConfiguration configuration;
    if (Platform.isAndroid) {
      configuration = PurchasesConfiguration(RevenueCatConstants.googleApiKey)
        ..appUserID = userId;
    } else {
      configuration = PurchasesConfiguration(RevenueCatConstants.appleApiKey)
        ..appUserID = userId;
    }
    await Purchases.configure(configuration);
  }

  Future<bool> isPro() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      return customerInfo
              .entitlements.all[RevenueCatConstants.entitlementId]?.isActive ??
          false;
    } catch (e, stackTrace) {
      await Sentry.captureException(
        e,
        stackTrace: stackTrace,
        hint: Hint.withMap({'context': 'revenue_cat_is_pro_failed'}),
      );
      return false;
    }
  }

  Future<List<Package>> getOfferings() async {
    try {
      final offerings = await Purchases.getOfferings();
      if (offerings.current != null) {
        return offerings.current!.availablePackages;
      }
    } catch (e, stackTrace) {
      await Sentry.captureException(
        e,
        stackTrace: stackTrace,
        hint: Hint.withMap({'context': 'revenue_cat_get_offerings_failed'}),
      );
    }
    return [];
  }

  Future<bool> purchasePackage(Package package) async {
    try {
      final customerInfo = await Purchases.purchasePackage(package);
      return customerInfo
              .entitlements.all[RevenueCatConstants.entitlementId]?.isActive ??
          false;
    } catch (e, stackTrace) {
      await Sentry.captureException(
        e,
        stackTrace: stackTrace,
        hint: Hint.withMap({'context': 'revenue_cat_purchase_failed'}),
      );
      return false;
    }
  }

  Future<void> restorePurchases() async {
    await Purchases.restorePurchases();
  }
}
