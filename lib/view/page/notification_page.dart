import 'package:flutter/material.dart';
import 'package:socflu/view/my_widgets/my_text.dart';

class NotificationPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NotificationState();
  }

}

class _NotificationState extends State<NotificationPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(child: MyText('Notification'),);
  }

}