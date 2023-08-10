import 'package:statsfl/statsfl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/dataReceiver.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import 'dart:math';
import 'page1.dart';

import 'mainpage.dart';
import 'opcuawebapi.dart';

void main() => runApp(StatsFl(
      child: MyApp(),
      align: Alignment.topRight,
      maxFps: 90,
    ));

class MyApp extends StatelessWidget {
  MyApp({super.key});
  OpcUaWebApi api = OpcUaWebApi("10.43.61.156", 8084, "/api/1.0/opcua");

  Future<int> connectSessionAndCreateSubscription() async {
    await api.openSession();
    var subscriptionId = await api.createSubscription();
    print("my subscriptionId: $subscriptionId");
    return subscriptionId;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: connectSessionAndCreateSubscription(),
      builder: (context, AsyncSnapshot<int> connectApi) {
        Widget widget;
        if (connectApi.connectionState == ConnectionState.done) {
          widget = MaterialApp(
            title: 'Flutter Hello World 2',
            theme: ThemeData(
              primarySwatch: Colors.red,
            ),
            home: MappViewVisu(
                title: 'mapp View - embedded ${connectApi.data}',
                api: api,
                subscriptionId: connectApi.data!),
          );
        } else {
          widget = Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return widget;
      },
    );
/*
    return MaterialApp(
      title: 'Flutter Hello World 2',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MappViewVisu(title: 'mapp View - embedded'),
    );
    */
  }
}
