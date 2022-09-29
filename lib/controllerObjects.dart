import 'package:flutter/material.dart';

class MonthlyInvObject extends Object {
  double _monthlyInvestment;

  TextEditingController _monthlyInvController;

  /* 
  * Constructor
  */
  MonthlyInvObject(this._monthlyInvestment, this._monthlyInvController);

  void setMonthInvestValue(double monInv) {
    _monthlyInvestment = monInv;
  }
}
