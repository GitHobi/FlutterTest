import 'package:flutter/material.dart';

Widget _buildButtonColumn(Color color, IconData icon, String label) {
  return Container(
    width: 60,
    height: 60,
    alignment: Alignment.center,
    color: Colors.white70,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget getButtonSection2(Color color) {
  return Container(
    margin: const EdgeInsets.only(top: 15, bottom: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 20),
        _buildButtonColumn(color, Icons.call, 'CALL'),
        SizedBox(width: 15),
        _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
        SizedBox(width: 15),
        _buildButtonColumn(color, Icons.share, 'SHARE'),
      ],
    ),
  );
}

Widget getButtonSection(Color color) {
  return Container(
    margin: const EdgeInsets.only(top: 15, bottom: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(color, Icons.call, 'CALL'),
        _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
        _buildButtonColumn(color, Icons.share, 'SHARE'),
      ],
    ),
  );
}

Widget getTwoButtonSections(BuildContext context) {
  Color color = Theme.of(context).primaryColor;

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      getButtonSection(color),
      Expanded(child: SizedBox()),
      getButtonSection(color)
    ],
  );
}
