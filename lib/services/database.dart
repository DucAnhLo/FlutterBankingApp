import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techcombank_clone/models/user.dart';
import 'package:techcombank_clone/models/user.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  

  //collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('user');

  Future updateUserData(String name, int accountNumber, int balance) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'accountNumber':accountNumber,
      'balance':balance
    });
  }

  Future getUserInformation() async {
    DocumentSnapshot userInformation = await userCollection.doc(uid).get();
    if(userInformation.exists){
      String name = userInformation.get('name');
      int accountNumber = userInformation.get('accountNumber');
      int balance = userInformation.get('balance');
    }else {
      print("Document does not exits");
    }

  }
}