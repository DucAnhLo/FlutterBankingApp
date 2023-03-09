import 'package:flutter/material.dart';
import 'package:techcombank_clone/pages/authenticate/authenticate.dart';
import 'package:techcombank_clone/pages/authenticate/sign_in.dart';
import 'package:techcombank_clone/pages/home.dart';
import 'package:techcombank_clone/pages/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    // // final user = Provider.of<UserData?>(context);

    // //return either Home or Authenticate
    // if(user == null){
    //   return Authenticate();
    // }else {
    //   print(user.toJson());
    //   return Home();
    // }

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return Home();
          }else {
            return Authenticate();
          }
        },
      )
    );
  }
}