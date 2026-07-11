import 'package:flutter/services.dart';

class AdConfig {
  static const MethodChannel _channel =
      MethodChannel('com.appsbay.classic_2048/ads');

  static String? _bannerId;
  static String? _appOpenId;

  static Future<void> initialize() async {
    try {
      final Map<dynamic, dynamic>? ids =
          await _channel.invokeMethod('getAdUnitIds');
      if (ids != null) {
        _bannerId = ids['banner'] as String?;
        _appOpenId = ids['appOpen'] as String?;
      }
    } on PlatformException catch (e) {
      print("Failed to get ad unit IDs: '${e.message}'.");
    }
  }

  static String get bannerAdUnitId => _bannerId ?? "";
  static String get appOpenAdUnitId => _appOpenId ?? "";
}
