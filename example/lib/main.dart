import 'dart:async';

import 'package:flutter/material.dart';
import 'package:umeng_analytics_plugin/umeng_analytics_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    var result = await UmengAnalyticsPlugin.init(
      androidKey: '5dfc5b91cb23d26df0000a90',
      iosKey: '5dfc5c034ca35748d1000c4c',
    );

    print('Umeng initialized.');

    if (!mounted) {
      return;
    }

    setState(() {
      _platformVersion = result ? 'OK' : 'ERROR';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
