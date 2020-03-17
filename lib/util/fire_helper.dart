import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:socflu/view/my_widgets/constant.dart';

class FireHelper{

  // Get Auth instance
  final _auth_instance = FirebaseAuth.instance;

  // SignIn
  Future<String> signIn(String email, String pwd) async{
    
    try{
      await _auth_instance.signInWithEmailAndPassword(email: email, password: pwd);
      return "";
    }catch(signInException){
//      debugPrint("MSG :"+signInException.code);
      return getMessageForCodeError(signInException.code);
      
    }
  }

  // SignUp
  Future<String> signUp(String email, String pwd, String firstName, String lastName) async{
    
    try{
      AuthResult result = await _auth_instance.createUserWithEmailAndPassword(email: email, password: pwd);
    
      final FirebaseUser user = result.user;

      // save others info in database
      List<dynamic> followers = [];
      List<dynamic> following = [user.uid];
      Map<String, dynamic> data = {
        KEY_FIRST_NAME: firstName,
        KEY_LAST_NAME: lastName,
        KEY_IMAGEURL: "",
        KEY_FOLLOWERS: followers,
        KEY_FOLLOWING: following,
        KEY_UID: user.uid
      };
      addUser(user.uid, data);
      return "";
    }catch(signUpException){
      
      return getMessageForCodeError(signUpException.code);
      
    }
    
    
  }

  // SignOut
  Future<void> signOut() async {
    return _auth_instance.signOut();
  }

  // Current User
  Future<FirebaseUser> currentUser() async{
    FirebaseUser user = await _auth_instance.currentUser();

    return user;
  }

  // Erreur code
  String getMessageForCodeError(String code){
    debugPrint("MSG2 :"+code);
    if(code == "ERROR_INVALID_EMAIL"){
      return "L'email saisi est invalide";
    }else if(code == "ERROR_USER_NOT_FOUND" || code == "ERROR_WRONG_PASSWORD"){
      return "L'email ou le mot de passe est incorrect";
    }else if(code == "ERROR_NETWORK_REQUEST_FAILED"){
      return "Veuillez vérifier votre connexion internet";
    }else if(code == "ERROR_EMAIL_ALREADY_IN_USE"){
      return "L'email saisi existe déjà";
    }else if(code == "ERROR_WEAK_PASSWORD"){
      return "Veuillez saisir un Mot de passe de 8 caractère minimum avec au moins un chiffre";
    }else if(code == "ERROR_INVALID_EMAIL"){
      return "L'email saisi est invalide";
    }
    return "Une erreur est survenue, veuillez réessayer plus tard";
    
  }

  // Database
  static final _cloud_fire_instance = Firestore.instance;
  final fire_user = _cloud_fire_instance.collection("users");

  addUser(String uid, Map<String, dynamic> data){
    
    fire_user.document(uid).setData(data);
  }

  addPost(String uid, String text, File image){
    List<dynamic> likes = [];
    List<dynamic> comments = [];
    int date = DateTime.now().millisecondsSinceEpoch.toInt();
    Map<String, dynamic> map = {
      KEY_UID: uid,
      KEY_LIKES: likes,
      KEY_COMMENTS: comments,
      KEY_DATE: date,
      KEY_TEXT: text
    };

    if(image!=null){
      StorageReference ref = storage_post.child(uid).child(date.toString());
      saveImage(image, ref).then((finalised){
        
        map[KEY_IMAGEURL] = finalised;
        fire_user.document(uid).collection("posts").document().setData(map);
      });
    }else {
      fire_user.document(uid).collection("posts").document().setData(map);
    }
  }

  Stream<QuerySnapshot> postsFrom(String uid) => fire_user.document(uid).collection("posts").snapshots();

  // Storage
  static final storage_instance = FirebaseStorage.instance.ref();
  final storage_user = storage_instance.child("users");
  final storage_post = storage_instance.child("posts");

  Future<String> saveImage(File image, StorageReference ref) async{
    StorageUploadTask storeTask = ref.putFile(image);
    StorageTaskSnapshot snapshot = await storeTask.onComplete;
    String urlImage = await snapshot.ref.getDownloadURL();

    return urlImage;
  }
}