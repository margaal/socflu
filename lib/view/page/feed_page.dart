import 'package:flutter/material.dart';
import 'package:socflu/view/my_widgets/my_text.dart';

class FeedPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FeedState();
  }

}

class _FeedState extends State<FeedPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(child: MyText('Fil d''actualité'),);
  }

}