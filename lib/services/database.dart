import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('user');

  Future updateUserData(String name, String accountNumber, int balance) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'accountNumber':accountNumber,
      'balance':balance
    });
  }

}