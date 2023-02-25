import 'package:flutter/material.dart';
import 'package:techcombank_clone/pages/transaction.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:techcombank_clone/pages/navbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String qrCode = 'Unknown';

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        false,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg1.jpeg'),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
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
                      Icons.menu,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,50,0,0),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    color: Colors.white
                  ),
                  width: 200,
                  height: 85,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Text('Balance:', style: TextStyle(fontSize: 19)),
                      SizedBox(height: 5),
                      Text('€580',style: TextStyle(fontSize: 30))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10,120,10,0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
                ),
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton(
                      onPressed: (){
                        _showDialog(context);
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.wallet, color: Colors.black),
                          Text("Transactions", style: TextStyle(color: Colors.grey))
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        scanQRCode();
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.qr_code, color: Colors.black),
                          Text("Scan QR", style: TextStyle(color: Colors.grey))
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: (){},
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.transform, color: Colors.black),
                          Text("Transfer", style: TextStyle(color: Colors.grey))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );       
  }
}

List<Transaction> transactions = [
  Transaction(
    id: 't1',
    title: 'New Shoes',
    amount: 69.99,
  ),
  Transaction(
    id: 't2',
    title: 'Weekly Groceries',
    amount: 16.53,
  ),
  Transaction(
    id: 't3',
    title: 'Movie Tickets',
    amount: 8.99,
  ),
  Transaction(
    id: 't4',
    title: 'Coffee',
    amount: 4.99,
  ),
  Transaction(
    id: 't5',
    title: 'Dinner',
    amount: 45.67,
  ),
];

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Recent transactions"),
        content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: transactions.length,
            itemBuilder: (BuildContext context, int index) {
              final transaction = transactions[index];
              return ListTile(
                title: Text(transaction.title),
                subtitle: Text('\€${transaction.amount}'),
              );
            },
          ),
        ),
      );
    },
  );
}



