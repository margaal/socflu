import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socflu/model/user.dart';
import 'package:socflu/view/my_material.dart';

class Post{
  DocumentReference ref;
  String documentID;
  String id;
  String text;
  String userId;
  String imageUrl;
  int date;
  List<dynamic> likes;
  List<dynamic> comments;
  //User user;

  Post(DocumentSnapshot snapshot){
    ref = snapshot.reference;
    documentID = snapshot.documentID;
    //user = user;
    Map<String, dynamic> map = snapshot.data;
    id = map[KEY_POSTID];
    text = map[KEY_TEXT];
    likes = map[KEY_LIKES];
    comments = map[KEY_COMMENTS];
    date = map[KEY_DATE];
    userId = map[KEY_UID];
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      KEY_POSTID: id,
      KEY_LIKES: likes,
      KEY_DATE:date,
      KEY_COMMENTS:comments,
      KEY_UID: userId
    };
    if(text != null){
      map[KEY_TEXT] = text;
    }
    if(imageUrl!=null){
      map[KEY_IMAGEURL] = imageUrl;
    }

    return map;
  }

}