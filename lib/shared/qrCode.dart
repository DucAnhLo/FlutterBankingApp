import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techcombank_clone/models/user.dart';


class qrCode extends StatefulWidget {
  const qrCode({super.key});

  @override
  State<qrCode> createState() => _qrCodeState();
}

class _qrCodeState extends State<qrCode> {
    String? name;
    int? accountNumber;
    int? balance;


  //  _fetch() async {
  //     final user = FirebaseAuth.instance.currentUser!;
  //     if(user != null){
  //       await FirebaseFirestore.instance
  //       .collection("user")
  //       .doc(user.uid)
  //       .get()
  //       .then((value){
  //         name = value.data()?['name'];
  //         accountNumber = value.data()?['accountNumber'];
  //         balance = value.data()?['balance'];
  //       });
  //     }
  //   }
  Future<UserData> _fetch() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User not authenticated"); // or return a default value
    }

    final snapshot = await FirebaseFirestore.instance
        .collection("user")
        .doc(user.uid)
        .get();
    if (!snapshot.exists) {
      throw Exception("User data not found"); // or return a default value
    }

    return UserData(
      uid: user.uid,
      name: snapshot.data()?['name'],
      accountNumber: snapshot.data()?['accountNumber'].toString() ?? '',
      balance: snapshot.data()?['balance'],
    );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg2.jpeg'),
            fit: BoxFit.fill
          )
        ),
        child: FutureBuilder(
          future: _fetch(),
          builder: (context, snapshot) {
            if(snapshot.connectionState != ConnectionState.done);
            final userData = snapshot.data;
            return Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,50,0,0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: CircleBorder(),
                          ),
                          child: Icon(
                            Icons.cancel,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, "/home");
                          },
                        ),
                ),
              ),
                  SizedBox(height: 110,),
                  Text("Scan to transfer to", style: TextStyle(fontSize: 21)),
                  Text("${userData?.name}", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                  Text("${userData?.accountNumber}",style: TextStyle(fontSize: 21)),
                  SizedBox(height: 50,),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: QrImage(
                        data:"${userData?.accountNumber}",
                        version: QrVersions.auto,
                        size: 300.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    SizedBox(height: 150,),
                    Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: SizedBox(
                      height: 100,
                      width: 50,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: CircleBorder(),
                          ),
                          child: Icon(
                            Icons.save,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            // print(userData?.accountNumber);
                            // print(userData?.uid);
                            // print(userData?.name);
                            // print(userData?.balance);
                            print(userData!.accountNumber);
                          },
                        ),
                ),
              ),
                    Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: SizedBox(
                      height: 100,
                      width: 50,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: CircleBorder(),
                          ),
                          child: Icon(
                            Icons.ios_share_outlined,
                            color: Colors.black,
                          ),
                          onPressed: () {

                          },
                        ),
                ),
              ),
                  ])
                ],
              ),
            );
          },
        ),
      )
    );
  }
}