import 'package:flutter/material.dart';
import 'dart:math';
import 'button_row.dart';
import 'displayCard.dart';
import 'infoCard.dart';

class Page1 extends StatelessWidget {
  const Page1({
    super.key,
    required this.random,
  });

  final Random random;

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
                iValue: random.nextInt(50) + 100,
                sValue: random.nextInt(50) + 100,
                aEntity: "Kessel",
                aAction: "heizen",
              ),
              EntityValue(
                iValue: random.nextInt(50) + 100,
                sValue: random.nextInt(50) + 100,
                aEntity: "Vorlauf",
                aAction: "kühlen",
              ),
              EntityValue(
                iValue: random.nextInt(50) + 100,
                sValue: random.nextInt(50) + 100,
                aEntity: "Rücklauf",
                aAction: "what ever",
              ),
              EntityValue(
                iValue: random.nextInt(50) + 100,
                sValue: random.nextInt(50) + 100,
                aEntity: "Rücklauf",
                aAction: "what ever",
              ),
              EntityValue(
                iValue: random.nextInt(50) + 100,
                sValue: random.nextInt(50) + 100,
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
                iValue: random.nextInt(50) + 100,
                sValue: random.nextInt(50) + 100,
                aEntity: "Kessel",
                aAction: "heizen",
              ),
              EntityValue(
                iValue: random.nextInt(50) + 100,
                sValue: random.nextInt(50) + 100,
                aEntity: "Vorlauf",
                aAction: "heizen",
              ),
              EntityValue(
                iValue: random.nextInt(50) + 100,
                sValue: random.nextInt(50) + 100,
                aEntity: "Rücklauf",
                aAction: "heizen",
              ),
              EntityValue(
                iValue: random.nextInt(50) + 100,
                sValue: random.nextInt(50) + 100,
                aEntity: "Rücklauf",
                aAction: "what ever",
              ),
              EntityValue(
                iValue: random.nextInt(50) + 100,
                sValue: random.nextInt(50) + 100,
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
