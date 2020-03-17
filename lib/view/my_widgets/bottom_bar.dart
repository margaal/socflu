import 'package:flutter/material.dart';
import 'package:socflu/view/my_material.dart';

class BottomBar extends BottomAppBar{

  BottomBar({@required List<Widget> items}):super(
    color: base,
    shape: CircularNotchedRectangle(),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: items,
    )
  );
}