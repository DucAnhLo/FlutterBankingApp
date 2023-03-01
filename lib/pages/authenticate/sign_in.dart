import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:techcombank_clone/services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = '';
  String password= '';
  final AuthService _auth = AuthService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Form(
          child: Container(
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage('assets/bg1.jpeg'),
              //     fit: BoxFit.cover
              //   )
              // ),
              padding: EdgeInsets.only(top: 150),
              child: Center(
                child: Column(children: [
                  SizedBox(height: 50,),
                  Icon(Icons.login,size: 100,),
                  SizedBox(height: 50,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      onChanged: (value){
                        setState(() {
                          email = value;
                        });
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400)
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: 'username'
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      onChanged: (value){
                        setState(() {
                          password = value;
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400)
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: 'password',
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  GestureDetector(
                    onTap: () async {
                      // dynamic result = await _auth.signInAno();
                      // if(result == null){
                      //   print('error signing in ');
                      // } else {
                      //   print('signed in');
                      //   print(result.uid);
                      // }
                      // Navigator.pushReplacementNamed(context, '/home');
                      print(email);
                      print(password);
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
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Not have an account ?',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),
                          ),
                          SizedBox(width: 20,),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(Colors.black)
                            ),
                            onPressed: (){
                              Navigator.pushReplacementNamed(context, '/signin');
                            }, 
                            child: Text('Register', style: TextStyle(color: Colors.white),))
                        ]
                      ),
                    ),
                ]),
              ),
            ),
        ),
        );
  }
}