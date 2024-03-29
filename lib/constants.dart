import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_tutorial/controllers/auth_controller.dart';
import 'package:tiktok_tutorial/views/screens/add_video_screen.dart';
import 'package:tiktok_tutorial/views/screens/profile_screen.dart';
import 'package:tiktok_tutorial/views/screens/search_screen.dart';
import 'package:tiktok_tutorial/views/screens/video_screen.dart';
import 'package:tiktok_tutorial/views/screens/warning_screen.dart';

List pages = [
  VideoScreen(),
  SearchScreen(),
  const WarningScreen(),
  Text('Messages Screen'),
  ProfileScreen(uid: authController.user.uid),
];

// COLORS
const backgroundColor = Color.fromARGB(255, 0, 0, 0);
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

// FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

// CONTROLLER
var authController = AuthController.instance;


String excla = '''
<svg width="47" height="47" viewBox="0 0 47 47" fill="none" xmlns="http://www.w3.org/2000/svg">
<rect x="6.73682" y="6.73682" width="40.2632" height="40.2632" fill="black"/>
<rect x="2" y="2" width="40.2632" height="40.2632" fill="#39DBFF" stroke="black" stroke-width="3" stroke-linejoin="round"/>
<path d="M31.7674 21.6744C31.7674 22.8105 31.5148 23.9355 31.0239 24.9851C30.5331 26.0347 29.8136 26.9884 28.9066 27.7917C27.9996 28.595 26.9229 29.2323 25.7378 29.6671C24.5528 30.1018 23.2827 30.3256 22 30.3256C20.7173 30.3256 19.4472 30.1018 18.2621 29.667C17.0771 29.2323 16.0004 28.595 15.0934 27.7917C14.1864 26.9884 13.4669 26.0347 12.976 24.9851C12.4852 23.9355 12.2325 22.8105 12.2325 21.6744L22 21.6744H31.7674Z" fill="black"/>
<rect x="12.2325" y="17.4884" width="3.34884" height="4.46512" fill="black"/>
<rect x="17.814" y="18.0465" width="3.34884" height="5.5814" fill="black"/>
<rect x="12.2325" y="18.0465" width="3.34884" height="19.5349" transform="rotate(-90 12.2325 18.0465)" fill="black"/>
<rect x="22.8372" y="18.0465" width="3.34884" height="5.5814" fill="black"/>
<rect x="20.6046" y="29.7674" width="3.34884" height="5.5814" fill="black"/>
<rect x="28.4186" y="17.4884" width="3.34884" height="4.46512" fill="black"/>
<path d="M25.0698 14.6977L31.7674 10.3474V19.0479L25.0698 14.6977Z" fill="black"/>
<path d="M18.9302 14.6977L12.2326 19.0479V10.3474L18.9302 14.6977Z" fill="black"/>
<path d="M22.2791 8L26.6294 14.6977H17.9288L22.2791 8Z" fill="black"/>
</svg>

''';