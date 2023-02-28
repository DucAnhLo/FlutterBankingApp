import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignInState();
}

class _SignInState extends State<SignUp> {
  final username = TextEditingController();
  final password= TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg1.jpeg'),
                fit: BoxFit.cover
              )
            ),
            padding: EdgeInsets.only(top: 150),
            child: Center(
              child: Column(children: [
                SizedBox(height: 50,),
                Icon(Icons.lock,size: 100,),
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    controller: username,
                    
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
                  child: TextField(
                    controller: password,
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
                  onTap: (){
                    
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
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ),
        );
  }
}