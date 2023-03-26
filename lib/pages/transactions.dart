import 'package:flutter/material.dart';
import 'package:techcombank_clone/models/transaction.dart';
import 'package:techcombank_clone/models/user.dart';
import 'package:techcombank_clone/services/auth.dart';
import 'package:techcombank_clone/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techcombank_clone/shared/qrCode.dart';
import 'package:awesome_dialog/awesome_dialog.dart';


class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  Object? data;
  CollectionReference transactions= FirebaseFirestore.instance.collection('transaction');
    // Get all documents from the collection
 void printAllTransactions() {
  transactions.snapshots().listen((querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      Object? dataFromDoc = doc.data();
      setState(() {
        data = dataFromDoc;
      });
    });
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children:[ 
              TextButton(
                onPressed: () {
                  printAllTransactions();
                },
              child: Text("Click"),
              ),
              Text("$data")
            ]
          )
        ),
      ),
    );
  }
}