import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socflu/model/user.dart';
import 'package:socflu/util/fire_helper.dart';
import 'package:socflu/view/my_material.dart';
import 'package:socflu/view/page/feed_page.dart';
import 'package:socflu/view/page/new_post.dart';
import 'package:socflu/view/page/notification_page.dart';
import 'package:socflu/view/page/profil_page.dart';
import 'package:socflu/view/page/user_page.dart';

class MainAppController extends StatefulWidget{

  String _uid;
  MainAppController(this._uid);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainAppState();
  }

}

class _MainAppState extends State<MainAppController>{

  StreamSubscription streamListener;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  int index = 0;
  
   @override
  void initState(){
    super.initState();
    streamListener = FireHelper().fire_user.document(widget._uid).snapshots().listen((document){
      setState(() {
        current_user = User(document);
      });
    });
  }

  @override
  void dispose(){
    streamListener.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (current_user==null? LoadingScaffold(): 
    Scaffold(
      key: _globalKey,
      bottomNavigationBar: BottomBar(items: 
        [
          BarItem(icon: Icon(Icons.home), onPressed: () => buttonSelectedAction(0), isSelected: (index==0)),
          BarItem(icon: Icon(Icons.group), onPressed: () => buttonSelectedAction(1), isSelected: (index==1)),
          Container(width: 0.0, height: 0.0,),
          BarItem(icon: Icon(Icons.notifications), onPressed: () => buttonSelectedAction(2), isSelected: (index==2)),
          BarItem(icon: Icon(Icons.account_circle), onPressed: () => buttonSelectedAction(3), isSelected: (index==3)),
        ]),
        floatingActionButton: FloatingActionButton(onPressed: write, child: Icon(Icons.chat_bubble), backgroundColor: pointer,),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: showPage(index)
       
      )
    );
  }

  Widget showPage(int index){
    switch(index){
      case 0:
        return FeedPage();
      case 1:
        return UserPage();
      case 2:
        return NotificationPage();
      case 3:
        return ProfilPage();

    }
  }

  write(){
    this._globalKey.currentState.showBottomSheet((builder) => NewPost());
  }

  buttonSelectedAction(int index){
    setState(() {
      this.index = index;
    });
  }

}