import 'package:firebase_auth/firebase_auth.dart';
import 'package:techcombank_clone/pages/authenticate/authenticate.dart';
import 'package:techcombank_clone/models/user.dart';
import 'package:techcombank_clone/services/database.dart';
import 'dart:math';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Random random = new Random();
  int? accountNumber;
  int? balance;
  

  MyUser? _userFromFirebaseUser(User user){
    return user != null ? MyUser(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<MyUser?> get myUser {
    return _auth.authStateChanges()
    .map((User? user) => _userFromFirebaseUser(user!));
  }
   
  //sign in Anonymous
  Future signInAno() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async{
    accountNumber = random.nextInt(900000) + 100000;
    balance = random.nextInt(90) + 10;
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      await DatabaseService(uid: user?.uid).updateUserData("Liam",accountNumber.toString(), balance!);
      return _userFromFirebaseUser(user!);
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