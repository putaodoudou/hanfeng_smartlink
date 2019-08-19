import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:hanfeng_smartlink/hanfeng_smartlink.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _wifiName = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String wifiName;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      wifiName = await HanfengSmartlink.getWifiName;
      bool isWifi = await HanfengSmartlink.isWifi;
      await HanfengSmartlink.startLink("Jack's iPhone", "nydju2haeys001");
    } on PlatformException {
      wifiName = 'Failed to get wifiName.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _wifiName = wifiName;
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
          child: Text('Running on: $_wifiName\n'),
        ),
      ),
    );
  }
}