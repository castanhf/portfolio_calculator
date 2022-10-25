import 'dart:math';

import 'package:flutter/material.dart';
import 'package:portfolio_calculator/controllerObjects.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:intl/intl.dart';

class WindowsLayout extends StatefulWidget {
  const WindowsLayout({Key? key}) : super(key: key);

  @override
  _WindowsLayoutState createState() => _WindowsLayoutState();
}

class _WindowsLayoutState extends State<WindowsLayout> {
  final TextEditingController _monthlyInvController = TextEditingController();
  final TextEditingController _returnRateController = TextEditingController();
  final TextEditingController _timePeriodController = TextEditingController();
  // ignore: prefer_final_fields
  static const double MONTHLYINVESTMENT = 25000;
  double _expectedReturnRate = 12;
  double _timePeriod = 10;

  // Controller objects declaration
  late MonthlyInvControllerObject monInvObject =
      MonthlyInvControllerObject(MONTHLYINVESTMENT, _monthlyInvController);

  late EstimatedReturnControllerObject retRateObject =
      EstimatedReturnControllerObject(
          _expectedReturnRate, _returnRateController);

  late TimePeriodControllerObject timePeriodObject =
      TimePeriodControllerObject(_timePeriod, _timePeriodController);

  late double _investedAmount;
  late double _estimatedReturns;
  late double _totalInvestment;
  late double i;

  NumberFormat decimalFormat = NumberFormat.decimalPattern('en_us');

  @override
  void initState() {
    //init  text in currency format
    monInvObject.txtEditContr.text =
        '\$${decimalFormat.format(monInvObject.controllerValue.floor())}';

    _returnRateController.text =
        retRateObject.controllerValue.toStringAsFixed(0);
    _timePeriodController.text = _timePeriod.toString();

    _investedAmount = (monInvObject.controllerValue * 12) * _timePeriod;

    i = (retRateObject.controllerValue) / (12 * 100);

    _estimatedReturns = (monInvObject.controllerValue *
            (((pow((1 + i), (_timePeriod * 12))) - 1) / i) *
            (1 + i)) -
        _investedAmount;

    _totalInvestment = _investedAmount + _estimatedReturns;
    super.initState();
  }

  //FV = P × ((1 + i)n - 1) / i) × (1 + i)
  //

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: <Widget>[
              // Monthly investment
              getTextLabelFromSliderValue(
                  context, monInvObject.txtEditContr, 'Monthly Investment'),
              getSliderThemeWidget(context, 500, 100000, monInvObject),

              // Expected return rate
              getTextLabelFromSliderValue(context, retRateObject.txtEditContr,
                  'Expected return rate (p.a)'), //Exp. return rate
              getSliderThemeWidget(context, 1, 30, retRateObject),

              // Time Period
              getTextLabelFromSliderValue(context,
                  timePeriodObject.txtEditContr, 'Time Period'), //Time Period
              getSliderThemeWidget(context, 1, 30, timePeriodObject),

              const SizedBox(height: 50),

              //Invested Amount
              getRegularTextLabel(context, 'Invested Amount', _investedAmount),

              //Estimated Returns
              getRegularTextLabel(context, 'Est. returns', _estimatedReturns),

              //Total investment
              getRegularTextLabel(context, 'Total value', _totalInvestment),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 20,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xFF98a4ff),
                    ),
                  ),
                  const SizedBox(width: 3),
                  const Text('Invested amount'),
                  const SizedBox(width: 30),
                  Container(
                    width: 20,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xFF5367ff),
                    ),
                  ),
                  const SizedBox(width: 3),
                  const Text('Estd. returns'),
                ],
              ),
              const SizedBox(height: 50),
              SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 30,
                    useRangeColorForAxis: true,
                    startAngle: 270,
                    endAngle: 270,
                    showLabels: false,
                    showTicks: false,
                    axisLineStyle: const AxisLineStyle(
                      thicknessUnit: GaugeSizeUnit.factor,
                      thickness: 0.35,
                      color: Color(0xFF98a4ff),
                    ),
                    ranges: <GaugeRange>[
                      GaugeRange(
                          startValue: 0,
                          endValue: 17,
                          color: const Color(0xFF98a4ff),
                          sizeUnit: GaugeSizeUnit.factor,
                          startWidth: 0.35,
                          endWidth: 0.35),
                      GaugeRange(
                          startValue: retRateObject.controllerValue,
                          endValue: 30,
                          sizeUnit: GaugeSizeUnit.factor,
                          color: const Color(0xFF5367ff),
                          startWidth: 0.35,
                          endWidth: 0.35),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20.0),
                    backgroundColor: Colors.greenAccent,
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                child: const Text('INVEST NOW'),
              )
            ],
          ),
        ],
      ),
    );
  }

  /* 
 * Renders a text label with green font and background.
 * The value follows the slider value
 */
  Widget getRegularTextLabel(
      BuildContext context, String textLabel, double amount) {
    Widget res;

    res = SizedBox(
      width: 350,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(textLabel),
            Text(
              //TODO - gotta change _investedAmount
              '\$${decimalFormat.format(amount.floor())}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );

    return res;
  }

/* 
 * Renders a text label with green font and background.
 * The value follows the slider value
 */
  Widget getTextLabelFromSliderValue(BuildContext context,
      TextEditingController paramController, String textLabel) {
    Widget res;

    res = SizedBox(
      width: 350,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              textLabel,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(
              width: 100,
              child: TextFormField(
                controller: paramController,
                decoration: const InputDecoration(
                  fillColor: Color(0xffe5faf5),
                  filled: true,
                  contentPadding: EdgeInsets.only(left: 30),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );

    return res;
  }

/* 
 * Renders a text label with green font and background.
 * The value follows the slider value
 */
  Widget getSliderThemeWidget(BuildContext context, dynamic slidMin,
      dynamic slidMax, ControllerObject controllerObject) {
    Widget res;

    res = SizedBox(
      width: 350,
      child: SfSliderTheme(
        data: SfSliderThemeData(
          activeTrackHeight: 5,
          inactiveTrackHeight: 5,
          activeTrackColor: const Color(0xff00d09c),
          inactiveTrackColor: Colors.black12,
          thumbColor: Colors.white,
          trackCornerRadius: 0,
          thumbRadius: 15,
        ),
        child: getSfSliderWidget(context, slidMin, slidMax, controllerObject),
      ),
    );

    return res;
  }

/* 
 * Build the SfSlider with
 * int min
 * int max
 * double value
 */
  Widget getSfSliderWidget(BuildContext context, dynamic slidMin,
      dynamic slidMax, ControllerObject controllerObject) {
    Widget res;

    res = SfSlider(
        min: slidMin,
        max: slidMax,
        value: controllerObject.controllerValue,
        onChanged: (dynamic value) {
          setControllerState(value, controllerObject);
        });

    return res;
  }

  /* 
   * Making a set state helper method here that works similarly to each
   * different Controller Object.
   */
  void setControllerState(dynamic value, ControllerObject controllerObject) {
    setState(() {
      double controlVal = 0;

      controllerObject.setControllerValue(value);
      controlVal = controllerObject.controllerValue;

      // TODO - this method body needs review

      // Some controller objs do not do the same calcs, so we need
      // this if block to check that for us.
      if (controllerObject is MonthlyInvControllerObject) {
        controllerObject.txtEditContr.text =
            '\$${decimalFormat.format(controlVal.floor())}';
        _investedAmount = (controlVal * 12) * _timePeriod;
      } else if (controllerObject is TimePeriodControllerObject) {
        controllerObject.txtEditContr.text = controlVal.toStringAsFixed(0);
        _investedAmount = (monInvObject.controllerValue * 12) * controlVal;
      } else {
        controllerObject.txtEditContr.text = controlVal.toStringAsFixed(0);
      }

      i = (retRateObject.controllerValue) / (12 * 100);
      _estimatedReturns = (monInvObject.controllerValue *
              (((pow((1 + i), (_timePeriod * 12))) - 1) / i) *
              (1 + i)) -
          _investedAmount;

      _totalInvestment = _investedAmount + _estimatedReturns;
    });
  }
}
