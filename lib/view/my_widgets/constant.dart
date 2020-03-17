import 'package:flutter/material.dart';
import 'package:socflu/model/user.dart';

// USer
User current_user;

const Color white = Colors.white;
const Color base = const Color(0xFF4DB6AC);
const Color baseAccent = const Color(0xFF26A69A); //0xFFFFA000
const Color pointer = const Color(0xFF1B5E20);
const Color errorColor = Colors.redAccent;

// Images
AssetImage logoImage = AssetImage("assets/socflu.png");
AssetImage eventImage = AssetImage("assets/event.jpg");
AssetImage homeImage = AssetImage("assets/home.jpg");
AssetImage profileImage = AssetImage("assets/profile.jpg");

// CONST KEYS
String KEY_FIRST_NAME = "firstName";
String KEY_LAST_NAME =  "lastName";
String KEY_DESCRIPTION = "description";
String KEY_IMAGEURL = "imageUrl";
String KEY_FOLLOWERS = "followers";
String KEY_FOLLOWING = "following";
String KEY_UID = "uid";
String KEY_POSTID = "postID";
String KEY_LIKES = "likes";
String KEY_COMMENTS = "comments";
String KEY_DATE = "date";
String KEY_TEXT = "text";