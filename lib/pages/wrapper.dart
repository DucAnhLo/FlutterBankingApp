import 'package:flutter/material.dart';
import 'package:techcombank_clone/pages/authenticate/authenticate.dart';
import 'package:techcombank_clone/pages/authenticate/sign_in.dart';
import 'package:techcombank_clone/pages/home.dart';
import 'package:techcombank_clone/pages/loading.dart';
import 'package:provider/provider.dart';
import 'package:techcombank_clone/models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);

    //return either Home or Authenticate
    if(user == null){
      return Authenticate();
    }else {
      return Home();
    }
  }
}