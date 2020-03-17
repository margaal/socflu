import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends TextField{
  MyTextField({@required TextEditingController controller,
  TextInputType type: TextInputType.text,
  String hint: "",
  Icon icon,
  bool obscure: false,
  int minLines: 1,
  int maxLines: 1}):super(
    controller:controller,
    keyboardType: type,
    obscureText: obscure,
    minLines: minLines,
    maxLines: maxLines,
    decoration: InputDecoration(
      hintText: hint,
      icon: icon
    )
  );
}