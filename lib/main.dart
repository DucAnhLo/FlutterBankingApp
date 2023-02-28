

import 'package:flutter/material.dart';
import 'package:techcombank_clone/pages/authenticate/sign_up.dart';
import 'package:techcombank_clone/pages/home.dart';
import 'package:techcombank_clone/pages/loading.dart';
import 'package:techcombank_clone/pages/wrapper.dart';





void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/loading',
    routes: {
      '/wrapper' :(context) => Wrapper(),
      '/loading':(context) => Loading(),
      '/home':(context) => Home(),
      'signup':(context) => SignUp()
    },
  ));                                                                                                                                                                       
}

