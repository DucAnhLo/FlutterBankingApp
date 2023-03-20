import 'package:flutter/material.dart';
import 'package:techcombank_clone/models/transaction.dart';
import 'package:techcombank_clone/models/user.dart';
import 'package:techcombank_clone/services/auth.dart';
import 'package:techcombank_clone/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Transfer extends StatefulWidget {
  final UserData qrCodeContent;
  const Transfer({super.key, required this.qrCodeContent});

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  @override
  Widget build(BuildContext context) {
    int amount;

    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 200,),
            Text("Your are transfering"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("£"),
                Flexible(child: SizedBox(
                  width: 100,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                          amount = value as int;
                        });
                    },
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'amount'
                    ),
                  ),
                ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("To"),
                SizedBox(width: 5,),
                Text("${widget.qrCodeContent}")
              ],
            ),
            SizedBox(height: 30,),
            GestureDetector(
                    onTap: () async{
                      MakeTransfer();
                    },
                    child: Container(
                      padding: EdgeInsets.all(25),
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Center(
                        child: Text(
                          'Send',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void MakeTransfer() async{
    AuthService _auth = AuthService();
    final user = FirebaseAuth.instance.currentUser!;
   // UserData receiverData = 
    // UserData currentUser = UserData(uid: user.uid);
    // Transactions sender = await DatabaseService(uid: user.uid).saveTransferDetail(currentUser, -1, "test", 1000);
    // Transactions receiver = await DatabaseService(uid: user.uid).saveTransferDetail(currentUser, 1, "test", 1000);
    // currentUser.balance = sender.type * sender.amount;

  }
}


