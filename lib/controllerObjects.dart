import 'package:flutter/material.dart';

class ControllerObject extends Object {
  double controllerValue = 0;
  TextEditingController txtEditContr = TextEditingController();

  /* 
  * Constructor
  */
  ControllerObject(this.controllerValue, this.txtEditContr);

  /*
  * Set state. Override this
  */
  void setControllerValue(double nContVal) {
    controllerValue = nContVal;
  }

  /*
  * Set state. Override this
  */
  void setControllerState() {}
}

class MonthlyInvObject extends ControllerObject {
  /* 
  * Constructor
  */
  MonthlyInvObject(super.contollerValue, super.txtEditContr);
}
