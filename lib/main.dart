import 'package:statsfl/statsfl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/dataReceiver.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import 'dart:math';
import 'page1.dart';

import 'mainpage.dart';

void main() => runApp(StatsFl(
      child: MyApp(),
      align: Alignment.topRight,
      maxFps: 90,
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Flutter Hello World 2',
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      // A widget which will be started on application startup
      home: MyHomePage(title: 'mapp View - embedded'),
    );
  }
}

