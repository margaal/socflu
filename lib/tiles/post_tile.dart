import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socflu/model/post.dart';
import 'package:socflu/model/user.dart';
import 'package:socflu/view/my_material.dart';

class PostTile extends StatelessWidget{

  final User user;
  final Post post; 
  final bool detail;

  const PostTile({@required User this.user, @required Post this.post, bool this.detail:false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child: Card(
        elevation: 5.0,
        child: PaddingWithChild(
          widget: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ProfileImage(urlString: user.imageUrl, onPressed: (){}),
                  Column(
                    children: <Widget>[
                      MyText("${user.firstName} ${user.lastName}"),
                      MyText("${post.date}", color: pointer,)
                    ],
                  )
                ],
              ),
              (post.imageUrl!=null && post.imageUrl!="")?PaddingWithChild(widget: Container(
                width: MediaQuery.of(context).size.width*0.85,
                height: MediaQuery.of(context).size.width*0.85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(image: CachedNetworkImageProvider(post.imageUrl), fit: BoxFit.cover))
              ), top: 5.0,): Container(height: 0.0),
              (post.text!=null && post.text!="")?PaddingWithChild(widget: MyText("${post.text}")):
              Container(height: 0.0,),
              PaddingWithChild(widget: Container(height: 1.0, width: MediaQuery.of(context).size.width,)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(icon: (post.likes.contains(current_user.uid)? Icon(Icons.favorite): Icon(Icons.favorite_border)), onPressed: (){},),
                  MyText(post.likes.length.toString(), color:baseAccent),
                  IconButton(icon: Icon(Icons.message), onPressed: null),
                  MyText(post.comments.length.toString(), color:baseAccent)
                ],
              )
            ],),
        )
      ),
    );
  }

}