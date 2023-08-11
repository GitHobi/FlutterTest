// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'numericOutput.dart';
import 'opcuawebapi.dart';

class EntityValue extends StatefulWidget {
  late String entity;
  late String action;
  final String binding_ist;
  final String binding_soll;

  final OpcUaWebApi api;
  final int subscriptionId;

  EntityValue(
      {super.key,
      required String aEntity,
      required String aAction,
      required this.binding_ist,
      required this.binding_soll,
      required this.api,
      required this.subscriptionId}) {
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
        width: 250,
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
                NumericOutput2(
                    api: widget.api,
                    subscriptionId: widget.subscriptionId,
                    binding: widget.binding_ist,
                    unit: "°C",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    )),
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
                SollWert(
                  api: widget.api,
                  subscriptionId: widget.subscriptionId,
                  binding: widget.binding_soll,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
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
  final String binding;

  final OpcUaWebApi api;
  final int subscriptionId;

  const SollWert(
      {super.key,
      required this.binding,
      required this.api,
      required this.subscriptionId});

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
        NumericOutput2(
            api: api,
            subscriptionId: subscriptionId,
            binding: binding,
            unit: "°C",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ))
      ],
    );
  }
}
