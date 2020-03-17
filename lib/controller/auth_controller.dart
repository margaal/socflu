
import 'package:flutter/material.dart';
import 'package:socflu/util/alert_helper.dart';
import 'package:socflu/util/fire_helper.dart';
import 'package:socflu/view/my_material.dart';

class AuthController extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AuthState();
  }

}

class _AuthState extends State<AuthController>{

  PageController _pageController;
  TextEditingController _mailEditingController;
  TextEditingController _pwdEditingController;
  TextEditingController _firstNameEditingController;
  TextEditingController _lastNameEditingController;

  @override
  void initState(){
    super.initState();
    _pageController = PageController();
    _mailEditingController = TextEditingController();
    _pwdEditingController = TextEditingController();
    _firstNameEditingController = TextEditingController();
    _lastNameEditingController = TextEditingController();
  }

  @override
  void dispose(){
    _pageController.dispose();
    _mailEditingController.dispose();
    _firstNameEditingController.dispose();
    _lastNameEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll){
          overscroll.disallowGlow();
        },
        child: SingleChildScrollView(
          child: InkWell(
            onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
            child: Container(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height >= 650.0) ? MediaQuery.of(context).size.height : 650.0,
            decoration: MyGradient(startColor: base, endColor: baseAccent),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  PaddingWithChild(widget: Image(image: logoImage, height: 100.0,)),
                  PaddingWithChild(widget: MenuTwoItems(item1: 'Connexion', item2: 'Inscription', pageController: _pageController), top:20.0, bottom: 20.0,),
                  Expanded(
                    flex: 2,
                    child: PageView(
                      controller: _pageController,
                      children: <Widget>[
                        AuthView(0), AuthView(1)
                      ],
                    ),
                  )
                  
                ]
              )
            ),
          )
          ),
        )
        )
    );
  }

  Widget AuthView(int index){
    return Column(
      children: <Widget>[
        PaddingWithChild(widget: Card(
          color: white, elevation: 7, shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: listItems((index == 0)),)
        )
        ), top: 15.0, bottom: 15.0, left: 20.0, right: 20.0),
        PaddingWithChild(
          top: 15.0,
          bottom: 15.0,
          widget: MyGradientButton(text: (index==0)? "Se connecter": "Inscription", onPressed: ()=> authTest(index==0)),
        )
      ],
    );
    /*return Container(
      decoration: BoxDecoration(color: white, borderRadius: BorderRadius.all(Radius.circular(10.0))),
      margin: EdgeInsets.only(left:10.0, right:10.0, bottom: 10.0),
    );*/
  }

  List<Widget> listItems(bool isSignIn){
    List<Widget> listWidget = [];

    if(!isSignIn){
      listWidget.add(MyTextField(controller: _firstNameEditingController, hint: "Prénom..."));
      listWidget.add(MyTextField(controller: _lastNameEditingController, hint: "Nom..."));
    }

    listWidget.add(MyTextField(controller: _mailEditingController, hint: "Email...", type: TextInputType.emailAddress,));
    listWidget.add(MyTextField(controller: _pwdEditingController, hint: "Mot de passe...", obscure: true,));

    return listWidget;
  }

  authTest(bool signIn) async{
    FocusScope.of(context).requestFocus(FocusNode());
    String email = _mailEditingController.text;
    String pwd = _pwdEditingController.text;
    String firstName = _firstNameEditingController.text;
    String lastName = _lastNameEditingController.text;
    if(signIn){
      if(email!="" && pwd!=""){
        String msg = await FireHelper().signIn(email.toLowerCase().trim(), pwd);
        if(msg!=null && msg!=""){
          //debugPrint(msg+" et");
          AlertHelper().error(context: context, errorTitle: "Erreur de connexion", error: msg);
        }
      }else{
        AlertHelper().error(context: context, error: "Veuillez compléter les champs");
      }
    }else{
      if(email!="" && pwd!="" && lastName!=""){
        String msg = await FireHelper().signUp(email.toLowerCase().trim(), pwd, firstName.toLowerCase().trim(), lastName.toUpperCase().trim());
        if(msg!=""){
          AlertHelper().error(context: context, errorTitle: "Erreur d'inscription", error: msg);
        }
      }else{
        AlertHelper().error(context: context, error: "Veuillez compléter les champs");
      }
    }
  }

}