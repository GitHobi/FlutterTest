import 'package:statsfl/statsfl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/dataReceiver.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import 'dart:math';
import 'page1.dart';

void main() => runApp(StatsFl(
      child: MyApp(),
      align: Alignment.topRight,
      maxFps: 90,
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Flutter Hello World 2',
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      // A widget which will be started on application startup
      home: MyHomePage(title: 'mapp View - embedded'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  String title = "mapp View embedded";
  DataBinding db = DataBinding();
  late TabController _tabController;
  
  static const int numItems = 200;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);
  List<_SalesData> data = [];

  int rounds = 0;

  void _genNewData() {
    var random = Random();
    data.clear();
    for (var i = 0; i < 200; i++) {
      var d = _SalesData("$i", random.nextDouble() * 10 + 20);
      data.add(d);
    }
  }

  @override
  void initState() {
    db.connectToData();
    db.setCallBackSetTitle(setTitle);

    _genNewData();

    super.initState();
    // Initialisieren Sie den TabController mit der Anzahl der Tabs, die Sie haben möchten
    _tabController = TabController(
        length: 7, vsync: this, animationDuration: Duration(seconds: 1));
  }

  @override
  void dispose() {
    _tabController
        .dispose(); // Den TabController freigeben, um Speicherlecks zu vermeiden
    super.dispose();
  }

  setTitle(String newTitle) {
    setState(() {
      title = newTitle;

      if (rounds > 20) {
        _genNewData();
        rounds=0;
      }
      rounds++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var random = Random();

    return Scaffold(
      appBar: AppBar(
        // The title text which will be shown on the action bar
        title: Text(title),

        bottom: TabBar(
          controller:
              _tabController, // Verwenden Sie den erstellten TabController hier
          tabs: [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.broadcast_on_home)),
            Tab(icon: Icon(Icons.info)),
            Tab(icon: Icon(Icons.account_tree)),
            Tab(icon: Icon(Icons.show_chart)),
            Tab(icon: Icon(Icons.build)),
            Tab(icon: Icon(Icons.settings)),
          ],
        ),
      ),
      body: TabBarView(
        controller:
            _tabController, // Verwenden Sie den gleichen TabController hier
        children: [
          Page1(random: random),
          Page1(random: random),
          //Center(child: Text('Inhalt der Einstellungen')),
          Center(
              child: ElevatedButton(
            child: Text("Press me"),
            onPressed: () => {setTitle("test")},
          )),
          Center(child: Text('Inhalt der Info')),
          Center(
              child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              width: double.infinity,
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text('Number'),
                  ),
                  DataColumn(
                    label: Text('Messwert'),
                  ),
                  DataColumn(
                    label: Text('Zeitstempel'),
                  )
                ],
                rows: List<DataRow>.generate(
                  numItems,
                  (int index) => DataRow(
                    color: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      // All rows will have the same selected color.
                      if (states.contains(MaterialState.selected)) {
                        return Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.08);
                      }
                      // Even rows will have a grey color.
                      if (index.isEven) {
                        return Colors.grey.withOpacity(0.3);
                      }
                      return null; // Use default value for other states and odd rows.
                    }),
                    cells: <DataCell>[
                      DataCell(Text('Row $index')),
                      DataCell(Text((data[index].year).toString())),
                      DataCell(Text((data[index].sales).toString()))
                    ],
                    selected: selected[index],
                    onSelectChanged: (bool? value) {
                      setState(() {
                        selected[index] = value!;
                      });
                    },
                  ),
                ),
              ),
            ),
          )),
          Center(child: Text('Inhalt der Build')),
          Column(children: [
            //Initialize the chart widget
            Expanded(
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  // Chart title
                  title: ChartTitle(text: 'Half yearly sales analysis'),
                  // Enable legend
                  legend: Legend(isVisible: true),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<_SalesData, String>>[
                    LineSeries<_SalesData, String>(
                        dataSource: data,
                        xValueMapper: (_SalesData sales, _) => sales.year,
                        yValueMapper: (_SalesData sales, _) => sales.sales,
                        name: 'Sales',
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: true))
                  ]),
            ),
          ]),
        ],
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
