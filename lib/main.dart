import 'package:flutter/material.dart';
import 'package:techcombank_clone/pages/home.dart';
import 'package:techcombank_clone/pages/loading.dart';



void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/' :(context) => Loading(),
      '/home':(context) => Home(),
    },
  ));
}

