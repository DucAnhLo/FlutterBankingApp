import 'package:firebase_auth/firebase_auth.dart';
import 'package:techcombank_clone/pages/authenticate/authenticate.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign in Anonymous
  Future signInAno() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //sign in with email and password
  //register with email and password
  //sign out
}