import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  //text controllers
  final _emailController = TextEditingController();


  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text.trim());
    }on FirebaseAuthException catch (e){
      print(e);
      showDialog(context: context,
          builder: (context){
            return AlertDialog(
              content:Text('Unregistered email',
                textAlign: TextAlign.center,) ,
            );
          });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
        elevation: 0,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Enter Your Email to receive a password reset link',
            textAlign: TextAlign.center,),

          SizedBox(height: 10),

          //Email Textfield
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Email')),
              ),
            ),
          ),
          SizedBox(height: 10),
          //Material Button
          MaterialButton(onPressed: passwordReset,
            child: Text('Reset Password',style:
            TextStyle(color: Colors.white),),
            color: Colors.brown[300],
          ),
        ],
      ),
    );
  }
}
