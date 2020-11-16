import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Umeng analytics plugin
class UmengAnalyticsPlugin {
  /// Method channel
  static const MethodChannel _channel = MethodChannel('jitao.tech/umeng_analytics_plugin');

  /// Initialize plugin with configurations.
  ///
  /// [androidKey] is for android app key.
  /// [iosKey] is for ios app key.
  /// [channel] is distribution for this app, can leave it empty.
  /// [logEnabled] turn on or off log, default for false.
  /// [encryptEnabled] turn on or off log encrypt, default for false.
  /// [sessionContinueMillis] time in milliseconds to upload analytics data.
  /// [catchUncaughtExceptions] whether to catch uncaught exceptions, default for true.
  /// [pageCollectionMode] how to collect page data, leave it AUTO is ok, for future details, read umeng doc.
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

  /// Send a page start event for [viewName]
  static Future<bool> pageStart(String viewName) async {
    Map<String, dynamic> map = {
      'viewName': viewName,
    };

    return _channel.invokeMethod<bool>('pageStart', map);
  }

  /// Send a page end event for [viewName]
  static Future<bool> pageEnd(String viewName) async {
    Map<String, dynamic> map = {
      'viewName': viewName,
    };

    return _channel.invokeMethod<bool>('pageEnd', map);
  }

  /// Send a general event for [eventId] with a [label]
  static Future<bool> event(String eventId, {String label= 'label'}) async {
    Map<String, dynamic> map = {
      'eventId': eventId,
    };

    if (label != null) {
      map['label'] = label;
    }

    return _channel.invokeMethod<bool>('event', map);
  }
}
