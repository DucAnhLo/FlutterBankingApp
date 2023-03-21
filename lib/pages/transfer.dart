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
      int? amount;
      Future<void> makeTransfer() async {
        AuthService _auth = AuthService();
        final user = FirebaseAuth.instance.currentUser!;
        UserData receiverData = await findReceiverUser(widget.qrCodeContent);
        print(receiverData.toJson());

        // Transactions sender = await DatabaseService(uid: user.uid)
        //     .saveTransferDetail(receiverData, -1, "test", amount!);
        // Transactions receiver = await DatabaseService(uid: receiverData.uid)
        //     .saveTransferDetail(user, 1, "test", amount!);

        // setState(() {
        //   receiverData.balance += amount!;
        // });

        // // update the sender's balance
        // UserData currentUser =
        //     await DatabaseService(uid: user.uid).getUserData() as UserData;
        // currentUser.balance = sender.type * sender.amount;
        // await DatabaseService(uid: user.uid).updateUserData(currentUser);
  }

    Future<UserData> findReceiverUser(String qrCodeContent) async {
  
    final querySnapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('accountNumber', isEqualTo: qrCodeContent)
        .get();
    print('Query snapshot: $querySnapshot');
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

  @override
  Widget build(BuildContext context) {
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
          ],
        ),
      ),
    );
  }
}


