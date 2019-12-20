import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class UMengAnalyticsPlugin {
  static const MethodChannel _channel =
      const MethodChannel('jitao.tech/umeng_analytics_plugin');

  static Future<bool> init({
    @required String androidKey,
    @required String iosKey,
    String channel,
    bool logEnabled = false,
    bool encryptEnabled = false,
    int sessionContinueMillis = 30000,
    bool catchUncaughtExceptions = true,
    String pageCollectionMode = 'AUTO',
  }) async {
    Map<String, dynamic> map = {
      'androidKey': androidKey,
      'iosKey': iosKey,
      'channel': channel,
      'logEnabled': logEnabled,
      'encryptEnabled': encryptEnabled,
      'sessionContinueMillis': sessionContinueMillis,
      'catchUncaughtExceptions': catchUncaughtExceptions,
      'pageCollectionMode': pageCollectionMode,
    };

    return _channel.invokeMethod<bool>('init', map);
  }

  static void onPageStart(String viewName) {
    Map<String, dynamic> map = {
      'viewName': viewName,
    };

    _channel.invokeMethod<bool>('onPageStart', map);
  }

  static void onPageEnd(String viewName) {
    Map<String, dynamic> map = {
      'viewName': viewName,
    };

    _channel.invokeMethod<bool>('onPageEnd', map);
  }

  static void onEvent(String eventId, {String label}) {
    Map<String, dynamic> map = {
      'eventId': eventId,
      'label': label,
    };

    _channel.invokeMethod<bool>('onEvent', map);
  }
}
