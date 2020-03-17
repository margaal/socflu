import 'package:flutter/material.dart';
import 'package:socflu/view/my_material.dart';

class LoadingCenter extends Center{

  LoadingCenter(): super(
    child: MyText("En cours...", fontSize: 46.0, color: baseAccent,)
  );
}