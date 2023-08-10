import 'package:flutter/material.dart';

import 'opcuawebapi.dart';

class NumericOutput2 extends StatefulWidget {
  const NumericOutput2(
      {super.key,
      required this.api,
      required this.subscriptionId,
      required this.binding,
      required this.style,
      required this.unit});

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
  int value = 0;
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

  Future<void> monitorData() async {
    if (!connected) {
      int handle =
          widget.binding.length; //blödsinnig - aber wird aktuell funktionieren!
      var monitoredItemId = await widget.api.monitorItems(
          "ns=6;s=${widget.binding}", widget.subscriptionId, handle);
      print("monitoredItemId = $monitoredItemId");
      widget.api.callbacks[handle] = (int handle, dynamic v) => {
            setState(() {
              print("incoming value: $v");
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
          if (snapshot.connectionState == ConnectionState.done) {
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
