import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:techcombank_clone/services/auth.dart';


class SignUp extends StatefulWidget {
  final toggleView;
  const SignUp({super.key, this.toggleView});

  @override
  State<SignUp> createState() => _SignInState();
}

class _SignInState extends State<SignUp> {
  String email = '';
  String password= '';
  String error = '';  
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Form(
          key: _formKey,
          child: Container(
              decoration: BoxDecoration(
                // image: DecorationImage(
                //   //image: AssetImage('assets/bg1.jpeg'),
                //   fit: BoxFit.cover
                // )
              ),
              padding: EdgeInsets.only(top: 150),
              child: Center(
                child: Column(children: [
                  SizedBox(height: 50,),
                  Icon(Icons.app_registration_rounded,size: 100,),
                  SizedBox(height: 50,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      validator: (value) => value!.isEmpty ? 'Enter an email' : null,
                      onChanged: (value) {
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
                      validator: (value) => value!.length < 6  ? 'Enter a password 6+ characters long' : null,
                      onChanged: (value) {
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
                    onTap: () async{
                      if(_formKey.currentState!.validate()){
                        dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                        if(result == null){
                          setState(() {
                            error = 'Please supply a valid email';
                          });
                        }
                      }
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
                  ),
                  SizedBox(height: 25),
                  Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
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
                                //Navigator.pushReplacementNamed(context, '/signin');
                                widget.toggleView();
                              }, 
                              child: Text('Sign In', style: TextStyle(color: Colors.white),))
                          ]
                        ),
                      ),
                  SizedBox(height: 12),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  )
            ]),
          ),
        ),
      ),
    );
  }
}