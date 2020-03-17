import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socflu/view/my_widgets/constant.dart';
import 'package:socflu/view/my_widgets/my_text.dart';

class AlertHelper{
  Future<void> error({BuildContext context, String errorTitle:"Erreur", String error}) async{
    MyText title  = MyText(errorTitle);
    MyText subtitle = MyText(error);
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext ctxt){
        return (Theme.of(context).platform == TargetPlatform.iOS)
        ? CupertinoAlertDialog(title: title, content: subtitle, actions:
        <Widget>[close(ctxt, "OK")])
        : AlertDialog(title: title, content: subtitle, actions: <Widget>[close(ctxt, "OK")],);
      }
    );
  }

  FlatButton close(BuildContext context, String text){
    return FlatButton(
      onPressed: () => Navigator.pop(context),
      child: MyText(text, color:errorColor)
    );
  }
}