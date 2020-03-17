import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socflu/util/fire_helper.dart';
import 'package:socflu/view/my_material.dart';

class NewPost extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewPostState();
  }

}

class NewPostState extends State<NewPost>{

  TextEditingController _postEditController = TextEditingController();
  File imagePicked;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: MediaQuery.of(context).size.height*0.75,
      color: base,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        child: InkWell(
          onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              PaddingWithChild(widget: MyText("Nouveau Post", fontSize: 30.0, color: pointer,), top:30),
              PaddingWithChild(widget: Container(
                width: MediaQuery.of(context).size.width-20,
                height: 1,
                color: pointer,
              ), left: 10, right: 10,),
              PaddingWithChild(widget: MyTextField(controller: _postEditController, minLines: 4, maxLines: 20, type: TextInputType.multiline,), left: 10, right: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      IconButton(icon: Icon(Icons.camera_enhance), onPressed: ()=> takePicture(ImageSource.camera)),
                      IconButton(icon: Icon(Icons.photo_library), onPressed: ()=> takePicture(ImageSource.gallery)),
                    ],
                  ),
                  Container(
                    width: 100.0,
                    height: 70.0,
                    child: (imagePicked==null? MyText("Pas d'image", fontSize: 22.0, color: pointer,) : Image.file(imagePicked)))
              ],) ,
              MyGradientButton(text: "Partager", onPressed: () => validatePost(), startColor: pointer, endColor: Colors.white70,)
            ],

          ),
        ),
      ),
    );
  }

  Future<void> takePicture(ImageSource source) async{
    File image = await ImagePicker.pickImage(source: source, maxWidth: 500.0, maxHeight: 500.0);
    setState(() {
      imagePicked = image;
    });
  }

  void validatePost(){

    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.pop(context);
    if(imagePicked!=null || (_postEditController.text!=null && _postEditController.text!="")){
      FireHelper().addPost(current_user.uid, _postEditController.text, imagePicked);
    }
  }

}