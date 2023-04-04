import 'package:flutter/material.dart';
import 'package:techcombank_clone/models/transaction.dart';
import 'package:techcombank_clone/models/user.dart';
import 'package:techcombank_clone/services/auth.dart';
import 'package:techcombank_clone/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techcombank_clone/shared/qrCode.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Trans extends StatefulWidget {
  const Trans({super.key});

  @override
  State<Trans> createState() => _TransactionsState();
}

class _TransactionsState extends State<Trans> {
  UserData? currentUser;
  List<Transactions>? userTransactions;


    Future<UserData> findSenderUser(User user) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(user.uid)
        .get();

    final userData = querySnapshot.data()!;
    return UserData(
      uid: user.uid, // use the user id from the parameter
      name: userData['name'],
      accountNumber: userData['accountNumber'],
      balance: userData['balance'],
    );
  }
    Future<void> _loadUserTransactions() async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('transaction')
      .where('user_id.accountNumber', isEqualTo: currentUser!.accountNumber)
      .get();

  final List<Transactions> transactions = [];
  for (var doc in querySnapshot.docs) {
    final user = await findSenderUser(FirebaseAuth.instance.currentUser!);
    final transaction = Transactions(
      user_id: user,
      type: doc['type'], 
      title: doc['title'], 
      amount: doc['amount'],
    );
    transactions.add(transaction);
    print(doc.data());
  }

  setState(() {
    userTransactions = transactions;
  });
}


  @override
void initState() {
  super.initState();
  // Use await to wait for the result of findSenderUser() before assigning it to currentUser
  findSenderUser(FirebaseAuth.instance.currentUser!).then((userData) {
    setState(() {
      currentUser = userData;
      _loadUserTransactions();
    });
  });
}


  @override
  Widget build(BuildContext context) {
    if (currentUser == null || userTransactions == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text("Balance: £${currentUser?.balance ?? 'Unknown'}"),
               Expanded(
                child: ListView.builder(
                  itemCount: userTransactions!.length,
                  itemBuilder: (context, index) {
                    final transaction = userTransactions![index];
                    return ListTile(
                      title: Text(transaction.title),
                      subtitle: Text(transaction.amount.toString()),
                      leading: Icon(transaction.type == 1 ? Icons.arrow_circle_up : Icons.arrow_circle_down),
                    );
                  },
                ),
              ),
              TextButton(onPressed: () {}, child: Text("Click "))
            ],
          ),
        ),
      ),
    );
  }
}

