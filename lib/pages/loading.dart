import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10,30,0,0),
                  child: Container(
                    decoration: BoxDecoration(
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Hello,', style: TextStyle(color: Colors.black, fontSize: 30),),
                        Text('Duc Anh Lo', style: TextStyle(color: Colors.black, fontSize: 30)),
                        SizedBox(
                          width: 100,
                          child: TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(Colors.white),
                              backgroundColor: MaterialStateProperty.all(Colors.black),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)
                                )
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/wrapper');
                            },
                            child: Text("Login", style: TextStyle(fontSize: 17)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
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
                      onPressed: (){},
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.wallet, color: Colors.black),
                          Text("Account & Cards", style: TextStyle(color: Colors.grey))
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: (){},
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
    );       ;
  }
}