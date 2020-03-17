import 'package:flutter/material.dart';
import 'package:socflu/view/my_widgets/my_text.dart';

class UserPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UserState();
  }

}

class _UserState extends State<UserPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(child: MyText('Utilisateur'),);
  }

}