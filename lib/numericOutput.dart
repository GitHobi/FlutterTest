import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'opcuawebapi.dart';

class NumericOutput2 extends StatefulWidget {
  const NumericOutput2(
      {super.key,
      required this.api,
      required this.subscriptionId,
      required this.binding,
      required this.style,
      required this.unit,
      this.id});

  final int? id;
  final TextStyle style;
  final String unit;
  final OpcUaWebApi api;
  final int subscriptionId;
  final String binding;

  @override
//  _NumericOutput createState() => _NumericOutput();
  NumericOutputState2 createState() {
    return NumericOutputState2();
  }
}

class NumericOutputState2 extends State<NumericOutput2> {
  int? value = null;
  TextStyle style = TextStyle();
  String unit = "";
  bool connected = false;

  @override
  void initState() {
    super.initState();

    value = 0;
    style = widget.style;
    unit = widget.unit;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> monitorData() async {
    //if (widget.id == null) return;
    if (!connected) {
      //int handle = widget.id!;
      var result = await widget.api.monitorItems(
          "ns=6;s=${widget.binding}", widget.subscriptionId, null);
      var handle = result['clientHandle'];
      //print("monitoredItemId = ${result['monitoredItemId']}");
      widget.api.callbacks[handle] = (int handle, dynamic v) => {
            if (mounted)
              setState(() {
                //          print("incoming value: $handle ---> $v");
                value = v;
              })
          };
      connected = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: monitorData(),
        builder: (context, AsyncSnapshot<void> snapshot) {
          Widget widget;
          //if (snapshot.connectionState == ConnectionState.done) {
          if (value != null) {
            widget = Text(
              "${value.toString()} $unit",
              style: style,
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
        });
  }
}

class NumericOutput extends StatefulWidget {
  const NumericOutput(
      {super.key,
      required this.value,
      required this.style,
      required this.unit});

  final int value;
  final TextStyle style;
  final String unit;

  @override
//  _NumericOutput createState() => _NumericOutput();
  NumericOutputState createState() {
    return NumericOutputState();
  }
}

class NumericOutputState extends State<NumericOutput> {
  int value = 0;
  TextStyle style = TextStyle();
  String unit = "";

  @override
  void initState() {
    super.initState();

    value = widget.value;
    style = widget.style;
    unit = widget.unit;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "${value.toString()} ${widget.unit}",
      style: style,
    );
  }
}
