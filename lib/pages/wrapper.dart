import 'package:flutter/material.dart';
import 'package:techcombank_clone/pages/authenticate/sign_in.dart';
import 'package:techcombank_clone/pages/home.dart';
import 'package:techcombank_clone/pages/loading.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    //return either Home or Authenticate
    return SignIn();
  }
}