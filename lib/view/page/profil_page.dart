import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socflu/delegate/header_delegate.dart';
import 'package:socflu/model/post.dart';
import 'package:socflu/tiles/post_tile.dart';
import 'package:socflu/util/fire_helper.dart';
import 'package:socflu/view/my_material.dart';
import 'package:socflu/view/my_widgets/my_text.dart';

class ProfilPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProfilState();
  }

}

class _ProfilState extends State<ProfilPage>{

  ScrollController _controller;
  double expanded = 200.0;
  bool get _showTitle {
    return _controller.hasClients && _controller.offset > (expanded - kToolbarHeight);
  }

  @override
  void initState(){
    super.initState();
    _controller = ScrollController()..addListener((){
      setState(() {
        
      });
    });
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<QuerySnapshot>(
      stream: FireHelper().postsFrom(current_user.uid),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(!snapshot.hasData){
          return LoadingScaffold();
        }else{
          List<DocumentSnapshot> documents = snapshot.data.documents;
          return CustomScrollView(
            controller: _controller,
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: expanded,
                actions: <Widget>[],
                flexibleSpace: FlexibleSpaceBar(
                  title: _showTitle? MyText(current_user.firstName+" "+current_user.lastName) : MyText(""),
                  background: Container(
                    decoration: BoxDecoration(image: DecorationImage(image: profileImage, fit:BoxFit.cover)),
                    child: Center(child: ProfileImage(urlString: current_user.imageUrl, size: 75.0, onPressed: (){},),)
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: HeaderDelegate(user: current_user, callback: null, scrolled: _showTitle),
              ),
              SliverList(delegate: SliverChildBuilderDelegate((BuildContext context, index){
                if(index==documents.length){
                  return ListTile(title: MyText("Fin des posts..."),);
                }else if(index>documents.length){
                  return null;
                }
                return PostTile(user: current_user, post: Post(documents[index]));
              })),
            ],
          );
        }
      },
    );
  }

}