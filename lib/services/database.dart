import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techcombank_clone/models/transactionlink.dart';
import 'package:techcombank_clone/models/user.dart';
import 'package:techcombank_clone/models/user.dart';
import 'package:techcombank_clone/models/transaction.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  

  //collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('user');
  final CollectionReference transactionCollection = FirebaseFirestore.instance.collection('transaction');
  final CollectionReference transactionLinkCollection = FirebaseFirestore.instance.collection('transactionLink');

  Future updateUserData(String name, String accountNumber, int balance) async {
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
      String accountNumber = userInformation.get('accountNumber');
      int balance = userInformation.get('balance');
    }else {
      print("Document does not exits");
    }

  }

    Future<Transactions> saveTransferDetail(UserData user, int type, String title, int amount) async {
     await transactionCollection.doc(uid).set({
      "type": type,
      "title": title,
      "user_id": user.toMap(),
      "amount":amount
    });
    Transactions trans = Transactions(user_id: user, type: type, title: title, amount: amount);
    return trans;
  }

  Future<TransactionLink> saveTransferLinkDetail(UserData fromUserId, UserData toUserID, DateTime now) async {
     await transactionLinkCollection.doc(uid).set({
     "transactionFromId": fromUserId.toMap(),
     "transactionToId": toUserID.toMap(),
     "dateTime": now
    });
    TransactionLink transLink = TransactionLink(transactionToId: fromUserId, transactionFromId: toUserID, dateTime:now);
    return transLink;
  }



  Future getTransferDetail() async {
    DocumentReference docRef = FirebaseFirestore.instance.collection('transaction').doc('Z2BNS5BDwBxhtbuHXQzt');
    docRef.get().then((DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      print(data); // This will print all the fields in the document
    } else {
      print('Document does not exist!');
    }
  }).catchError((error) => print(error));

  }

}