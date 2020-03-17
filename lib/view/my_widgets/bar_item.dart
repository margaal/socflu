import 'package:flutter/material.dart';
import '../my_material.dart';

class BarItem extends IconButton{

  BarItem({@required Icon icon, @required VoidCallback onPressed, @required bool isSelected}):super(
    icon: icon,
    onPressed: onPressed,
    color: (isSelected? white:pointer)
  );
}