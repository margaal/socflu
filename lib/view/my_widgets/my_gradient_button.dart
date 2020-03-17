import 'package:flutter/material.dart';
import 'package:socflu/view/my_widgets/my_text.dart';

import '../my_material.dart';

class MyGradientButton extends Card{

  MyGradientButton({@required String text, @required VoidCallback onPressed, double elevation:7.5,
  double width:300.0, double height: 50.0, Color startColor:base, Color endColor:baseAccent}):super(
    
    elevation: elevation,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(height * 0.5)),
    child: Container(
      width:width,
      height: height,
      decoration: MyGradient(startColor: startColor, endColor: endColor, radius: height*0.5, isHorizontal: true),
      child: FlatButton(
        onPressed: onPressed,
        child: MyText(text),
      ),
    ),
          
  );
}