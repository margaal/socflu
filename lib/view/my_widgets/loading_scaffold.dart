import 'package:flutter/material.dart';
import 'package:socflu/view/my_material.dart';

class LoadingScaffold extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(child: LoadingCenter()) 
    );
  }

}