import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socflu/view/my_widgets/constant.dart';

class User{

  String uid;
  String firstName;
  String lastName;
  String imageUrl;
  String description;
  List<dynamic> followers;
  List<dynamic> following;
  DocumentReference ref;
  String documentId;

  User(DocumentSnapshot snapshot){
    ref = snapshot.reference;
    documentId = snapshot.documentID;
    Map<String, dynamic> map = snapshot.data;
    uid = map[KEY_UID];
    firstName = map[KEY_FIRST_NAME];
    lastName = map[KEY_LAST_NAME];
    imageUrl = map[KEY_IMAGEURL];
    description = map[KEY_DESCRIPTION];
    followers = map[KEY_FOLLOWERS];
    following = map[KEY_FOLLOWING];
  }

  Map<String, dynamic> toMap(){
    return {
      KEY_UID: uid,
      KEY_FIRST_NAME: firstName,
      KEY_LAST_NAME: lastName,
      KEY_DESCRIPTION: description,
      KEY_IMAGEURL: imageUrl,
      KEY_FOLLOWERS: followers,
      KEY_FOLLOWING: following
    };
  }
}