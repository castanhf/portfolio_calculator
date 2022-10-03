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

/*
 * Monthly Investment object class
 */
class MonthlyInvControllerObject extends ControllerObject {
  /* 
  * Constructor
  */
  MonthlyInvControllerObject(super.contollerValue, super.txtEditContr);
}

/*
 * Monthly Investment object class
 */
class EstimatedReturnControllerObject extends ControllerObject {
  /* 
  * Constructor
  */
  EstimatedReturnControllerObject(super.contollerValue, super.txtEditContr);
}

/*
 * Time Period object class
 */
class TimePeriodControllerObject extends ControllerObject {
  /* 
  * Constructor
  */
  TimePeriodControllerObject(super.contollerValue, super.txtEditContr);
}
