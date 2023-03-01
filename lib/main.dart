
import 'package:flutter/material.dart';
import 'package:techcombank_clone/models/user.dart';
import 'package:techcombank_clone/pages/authenticate/sign_in.dart';
import 'package:techcombank_clone/pages/authenticate/sign_up.dart';
import 'package:techcombank_clone/pages/home.dart';
import 'package:techcombank_clone/pages/loading.dart';
import 'package:techcombank_clone/pages/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:techcombank_clone/services/auth.dart';





Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(StreamProvider<MyUser?>.value(
    catchError: (_, __) => null,
    initialData: null,
    value: AuthService().myUser,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/wrapper',
      routes: {
        '/wrapper' :(context) => Wrapper(),
        '/loading':(context) => Loading(),
        '/home':(context) => Home(),
        '/signup':(context) => SignUp(),
        '/signin':(context) => SignIn()
      },
    ),
  ));                                                                                                                                                                       
}

