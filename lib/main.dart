import 'package:flutter/material.dart';
import 'package:wemap_test_app/screens/main_page.dart';

import 'package:wemapgl/wemapgl.dart' as WEMAP;

import 'enums.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/main-page',
      routes: {
        MainPage.id: (context) => MainPage(),
      }
    );
  }
}

void main() {
  WEMAP.Configuration.setWeMapKey(weMapApiKey);
  runApp(MyApp());
}
