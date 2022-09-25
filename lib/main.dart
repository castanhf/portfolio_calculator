import 'package:flutter/material.dart'; //need this to use theme.dart
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import "package:intl/intl.dart";

void main() {
  runApp(const PortfolioCalculator());
}

/*
 * Main class - Portfolio calculator
 */
class PortfolioCalculator extends StatelessWidget {
  const PortfolioCalculator({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  //Init or default variables before build is called
  double monthlyInvestment = 1000;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    NumberFormat decimalFormat = NumberFormat.decimalPattern('en_us');
    _controller.text = '\$' + decimalFormat.format(monthlyInvestment.floor());

    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          //TextField had to come first to make this work
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              fillColor: Color(0xffe5faf5),
              filled: true,
              contentPadding: EdgeInsets.all(15),
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
            style: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          SfSliderTheme(
            data: SfSliderThemeData(
              activeTrackHeight: 5,
              inactiveTrackHeight: 5,
              activeTrackColor: const Color(0xff00d09c),
              inactiveTrackColor: Colors.black12,
              thumbColor: Colors.white,
              trackCornerRadius: 0,
              thumbRadius: 15,
            ),
            child: SfSlider(
                min: 500,
                max: 100000,
                value: monthlyInvestment,
                onChanged: (newValue) {
                  setState(() {
                    monthlyInvestment = newValue;
                    //interpolation used here
                    _controller.text =
                        '\$${decimalFormat.format(monthlyInvestment.floor())}';
                  });
                }),
          ),
        ],
      ),
    ));
  }
}
