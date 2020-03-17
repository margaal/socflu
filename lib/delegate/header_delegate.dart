 import 'package:flutter/material.dart';
import 'package:socflu/model/user.dart';
import 'package:socflu/view/my_material.dart';

class HeaderDelegate extends SliverPersistentHeaderDelegate{

  User user;
  VoidCallback callback;
  bool scrolled;

  HeaderDelegate({@required this.user, @required this.callback, @required this.scrolled});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      padding: EdgeInsets.all(10.0),
      color: baseAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          (scrolled)? Container(width: 0.0, height: 0.0,):MyText("${user.firstName} ${user.lastName}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ProfileImage(urlString: user.imageUrl, onPressed: (){}),
              MyText((user.description==null? "Aucune description":user.description), color: white,)
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1.0,
            color: base,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              InkWell(child: MyText("Abonnements: ${user.following.length-1}", color: white),),
              InkWell(child: MyText("Abonnés: ${user.followers.length}", color: white,))
            ],
          )
        ],
      ),
    );
  }

  @override
  
  double get maxExtent => (scrolled)? 150.0:200.0;

  @override
  // TODO: implement minExtent
  double get minExtent => (scrolled)? 150.0:200.0;

  @override
  bool shouldRebuild(HeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return (scrolled!=oldDelegate.scrolled || user != oldDelegate.user);
  }

}