import 'package:flutter/material.dart';
import 'dart:math';
import 'button_row.dart';
import 'displayCard.dart';
import 'entityvalue.dart';
import 'opcuawebapi.dart';

class Page1 extends StatelessWidget {
  const Page1({
    super.key,
    required this.api,
    required this.subscriptionId,
  });

  final OpcUaWebApi api;
  final int subscriptionId;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Container(
          color: Colors.grey, // Hintergrundfarbe der ersten Spalte
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              buildDisplayCard("S4 Turbo"),
              SizedBox(height: 20),
              buildDropDown(),
              SizedBox(height: 10),
              buildDropDown(),
              Expanded(child: SizedBox()),
              getButtonSection2(Colors.black87),
            ],
          ),
        ),
      ),
      Expanded(
        child: Container(
          child: Column(
            children: [
              EntityValue(
                api: api,
                subscriptionId: subscriptionId,
                binding_ist: "::Program:LocalVar1",
                binding_soll: "::Program:LocalVar2",
                aEntity: "Kessel",
                aAction: "heizen",
              ),
              EntityValue(
                api: api,
                subscriptionId: subscriptionId,
                binding_ist: "::Program:LocalVar3",
                binding_soll: "::Program:LocalVar4",
                aEntity: "Vorlauf",
                aAction: "kühlen",
              ),
              EntityValue(
                api: api,
                subscriptionId: subscriptionId,
                binding_ist: "::Program:LocalVar5",
                binding_soll: "::Program:LocalVar6",
                aEntity: "Rücklauf",
                aAction: "what ever",
              ),
              EntityValue(
                api: api,
                subscriptionId: subscriptionId,
                binding_ist: "::Program:LocalVar7",
                binding_soll: "::Program:LocalVar8",
                aEntity: "Rücklauf",
                aAction: "what ever",
              ),
              EntityValue(
                api: api,
                subscriptionId: subscriptionId,
                binding_ist: "::Program:LocalVar9",
                binding_soll: "::Program:LocalVar10",
                aEntity: "Rücklauf",
                aAction: "what ever",
              ),
            ],
          ),
        ),
      ),
      Expanded(
        child: Container(
          child: Column(
            children: [
              EntityValue(
                api: api,
                subscriptionId: subscriptionId,
                binding_ist: "::Program1:LocalVar1",
                binding_soll: "::Program1:LocalVar2",
                aEntity: "Kessel",
                aAction: "heizen",
              ),
              EntityValue(
                api: api,
                subscriptionId: subscriptionId,
                binding_ist: "::Program1:LocalVar3",
                binding_soll: "::Program1:LocalVar4",
                aEntity: "Vorlauf",
                aAction: "heizen",
              ),
              EntityValue(
                api: api,
                subscriptionId: subscriptionId,
                binding_ist: "::Program1:LocalVar5",
                binding_soll: "::Program1:LocalVar6",
                aEntity: "Rücklauf",
                aAction: "heizen",
              ),
              EntityValue(
                api: api,
                subscriptionId: subscriptionId,
                binding_ist: "::Program1:LocalVar7",
                binding_soll: "::Program1:LocalVar8",
                aEntity: "Rücklauf",
                aAction: "what ever",
              ),
              EntityValue(
                api: api,
                subscriptionId: subscriptionId,
                binding_ist: "::Program1:LocalVar9",
                binding_soll: "::Program1:LocalVar10",
                aEntity: "Rücklauf",
                aAction: "what ever",
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
