import 'package:flutter/material.dart';

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
  NumericOutputState createState()
  {
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
