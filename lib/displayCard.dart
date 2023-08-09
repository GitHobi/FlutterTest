import 'package:flutter/material.dart';

Widget buildDropDown() {
  return Container(
    alignment: Alignment.centerLeft,
    //color: Colors.red,
    margin: const EdgeInsets.only(left: 20, right: 20),
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white70, //background color of dropdown button
//        border: Border.all(
//            color: Colors.black38, width: 0), //border of dropdown button
      ),
      child: DropdownButton(
        isExpanded: true,
        underline: SizedBox(),
        padding: EdgeInsets.symmetric(horizontal: 15),
        value: "1",
        items: [
          DropdownMenuItem(
            child: Row(
              children: [
                Icon(Icons.power, color: Colors.green, size: 30),
                Text("Zündung EIN"),
              ],
            ),
            value: "1",
          ),
          DropdownMenuItem(
            child: Row(
              children: [
                Icon(Icons.no_encryption, color: Colors.red, size: 30),
                Text("Zündung AUS"),
              ],
            ),
            value: "0",
          )
        ],
        icon: Padding(
            //Icon at tail, arrow bottom is default icon
            padding: EdgeInsets.only(left: 20),
            child: Icon(Icons.arrow_circle_down_sharp)),
        iconEnabledColor: Colors.black38, //Icon color
        style: TextStyle(
          //te
          color: Colors.black87, //Font color
          fontSize: 15, //font size on dropdown button
          fontWeight: FontWeight.w500,
        ),
        dropdownColor: const Color.fromARGB(250, 200, 200, 200),
        onChanged: (value) {
          //get value when changed
          print("You selected $value");
        },
      ),
    ),
  );
}

Widget buildDisplayCard(String label) {
  return Container(
    alignment: Alignment.center,
    //color: Colors.white70,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          color: Colors.white70,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/S4-Turbo.png',
                  height: 70,
                  fit: BoxFit.contain,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: Colors.lightGreen,
                            size: 24,
                          ),
                          SizedBox(width: 5),
                          Text("fehlerfrei"),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
