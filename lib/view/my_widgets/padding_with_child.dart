import 'package:flutter/material.dart';

class PaddingWithChild extends Padding{

  PaddingWithChild({
    @required Widget widget,
    double top: 10.0,
    double left: 0.0,
    double bottom: 0.0,
    double right: 0.0,
  }):super(
    padding: EdgeInsets.only(
      top:top,
      bottom: bottom,
      right: right,
      left: left
    ),
    child: widget
  );
}