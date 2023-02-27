import 'package:flutter/material.dart';
import 'package:techcombank_clone/pages/home.dart';
import 'package:techcombank_clone/pages/loading.dart';
import 'package:techcombank_clone/pages/wrapper.dart';





void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/' :(context) => Wrapper(),
      '/loading':(context) => Loading(),
      '/home':(context) => Home(),

    },
  ));
}

