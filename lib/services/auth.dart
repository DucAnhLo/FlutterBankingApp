
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:techcombank_clone/pages/authenticate/authenticate.dart';
import 'package:techcombank_clone/models/user.dart';
import 'package:techcombank_clone/pages/loading.dart';
import 'package:techcombank_clone/services/database.dart';
import 'dart:math';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Random random = new Random();
  String? accountNumber;
  int? balance;
  

  // UserData? _userFromFirebaseUser(User user){
  //   // ignore: unnecessary_null_comparison
  //   return user != null ? UserData(uid: user.uid, accountNumber: '') : null;
  // }

  // //auth change user stream
  // Stream<UserData?> get myUser {
  //   return _auth.authStateChanges()
  //   .map((User? user) => _userFromFirebaseUser(user!));
  // }
   
  // //sign in Anonymous
  // Future signInAno() async {
  //   try {
  //     UserCredential result = await _auth.signInAnonymously();
  //     User? user = result.user;
  //     return _userFromFirebaseUser(user!);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // return _userFromFirebaseUser(user!);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
  }


  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async{
    accountNumber = (random.nextInt(900000) + 100000).toString();
    balance = random.nextInt(90) + 10;
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      await DatabaseService(uid: user?.uid).updateUserData(email,accountNumber!,balance!);
      // return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  } 


  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}