import 'package:firebase_auth/firebase_auth.dart';
import 'package:techcombank_clone/pages/authenticate/authenticate.dart';
import 'package:techcombank_clone/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

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
  //register with email and password
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