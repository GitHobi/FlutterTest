// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'numericOutput.dart';

class EntityValue extends StatefulWidget {
  late int istValue;
  late int sollValue;
  late String entity;
  late String action;

  EntityValue(
      {super.key,
      required int iValue,
      required int sValue,
      required String aEntity,
      required String aAction}) {
    istValue = iValue;
    sollValue = sValue;
    entity = aEntity;
    action = aAction;
  }

  @override
  _EntityValue createState() => _EntityValue();
}

class _EntityValue extends State<EntityValue> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(2, 5), // changes position of shadow
          ),
        ],
      ),

      margin: const EdgeInsets.all(20),
      //color: Colors.black12,
      child: Container(
        width: 200,
        height: 100,
        margin: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(Icons.heat_pump_outlined, size: 30, color: Colors.black54)
              ],
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.entity}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      "${widget.action}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black26,
                      ),
                    ),
                  ],
                ),
                NumericOutput(
                    value: widget.istValue,
                    unit: "°C",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ))
              ],
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SollIcon(),
                //Expanded(child: SizedBox()),
                //SizedBox(height: 35),

                //Spacer()
                SollWert(value: widget.sollValue),
                NumericOutput(
                    value: widget.sollValue,
                    unit: "°C",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}



Widget getInfoCard(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(2, 5), // changes position of shadow
        ),
      ],
    ),

    margin: const EdgeInsets.all(10),
    //color: Colors.black12,
    child: Container(
      width: 200,
      height: 100,
      margin: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(Icons.heat_pump_outlined, size: 30, color: Colors.black54)
            ],
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kessel",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    "Heizen",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black26,
                    ),
                  ),
                ],
              ),
              Text(
                "127 °C",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              )
            ],
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SollIcon(),
              //Expanded(child: SizedBox()),
              //SizedBox(height: 35),

              //Spacer()
              SollWert(value: 123),
            ],
          ),
        ],
      ),
    ),
  );
}

class SollIcon extends StatelessWidget {
  const SollIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.fireplace_outlined,
      size: 30,
      color: Color.fromARGB(255, 255, 0, 0),
    );
  }
}

class SollWert extends StatelessWidget {
  final int value;

  const SollWert({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Soll",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
        Text(
          value.toString() + " °C",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        )
      ],
    );
  }
}
