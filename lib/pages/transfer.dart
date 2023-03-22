import 'package:flutter/material.dart';
import 'package:techcombank_clone/models/transaction.dart';
import 'package:techcombank_clone/models/user.dart';
import 'package:techcombank_clone/services/auth.dart';
import 'package:techcombank_clone/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techcombank_clone/shared/qrCode.dart';

class Transfer extends StatefulWidget {
  final String qrCodeContent;
  const Transfer({super.key, required this.qrCodeContent});

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
      String error = "";
      int? amount;
      Future<void> makeTransfer() async {
        AuthService _auth = AuthService();
        final user = FirebaseAuth.instance.currentUser!;
        UserData senderData = await findSenderUser(user.uid);
        UserData receiverData = await findReceiverUser(widget.qrCodeContent);

        
        // Validate sender balance
        if((amount ?? 0) > (senderData.balance  ?? 0)){
          setState(() {
            error = "Not enough money to make transfer";
          });
        } else {
          Transactions sender = await DatabaseService(uid: user.uid)
            .saveTransferDetail(senderData, -1, "Mua rau", amount!);
          Transactions receiver = await DatabaseService(uid: receiverData.uid)
            .saveTransferDetail(receiverData,1,"Ban rau", amount!);

        // Update the balance of the receiver
          receiverData.balance = (receiverData.balance ?? 0) + (amount ?? 0) * receiver.type;
          final receiverQuerySnapshot = await FirebaseFirestore.instance
            .collection('user')
            .where('accountNumber', isEqualTo: receiverData.accountNumber)
            .get();
          if (receiverQuerySnapshot.docs.isNotEmpty) {
            String docId = receiverQuerySnapshot.docs[0].id;
            await FirebaseFirestore.instance
              .collection('user')
              .doc(docId)
              .update({'balance': receiverData.balance});
          // Update the balance of the sender
            senderData.balance = (senderData.balance ?? 0) + (amount ?? 0) * sender.type;
            final senderQuerySnapshot = await FirebaseFirestore.instance
              .collection('user')
              .where('accountNumber', isEqualTo: senderData.accountNumber)
              .get();
            if (senderQuerySnapshot.docs.isNotEmpty) {
              String docId = senderQuerySnapshot.docs[0].id;
              await FirebaseFirestore.instance
                .collection('user')
                .doc(docId)
                .update({'balance': senderData.balance});
            }
          }
        }
  }

  Future<UserData> findReceiverUser(String qrCodeContent) async {
  
    final querySnapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('accountNumber', isEqualTo: qrCodeContent)
        .get();
    if (querySnapshot.docs.isEmpty) {
      throw Exception('User not found');
    }

    final userData = querySnapshot.docs.first.data();
    return UserData(
      uid: userData['uid'],
      name: userData['name'],
      accountNumber: userData['accountNumber'],
      balance: userData['balance'],
    );
  }

  Future<UserData> findSenderUser(String uid) async {
  
    final querySnapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .get();

    final userData = querySnapshot.data()!;
    return UserData(
      uid: userData['uid'],
      name: userData['name'],
      accountNumber: userData['accountNumber'],
      balance: userData['balance'],
    );
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer'),
      ),
      body:  SingleChildScrollView(
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
                            try {
                              amount = int.parse(value);
                            } catch (e) {
                              // Handle the error by setting amount to zero or showing an error message
                              amount = 0;
                            }
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
                        makeTransfer();
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
              Text("$error", style: TextStyle(
                color: Colors.red,
                fontSize: 20
              ),)
            ],
          ),
        ),
      );
  }
}


