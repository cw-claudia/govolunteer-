import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:core';
import 'package:email_validator/email_validator.dart';
import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key
    ,required this.showRegisterPage }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final FirebaseAuth auth = FirebaseAuth.instance;
//text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late String emailValidator ;
  late String passwordvalidator;
  late bool isValid;


  Future signIn() async {
    validator();
    //show a loading circle
    showDialog(
      context: context,
      builder: (context){
        return Center(child: CircularProgressIndicator());

      },
    );
    final User? user = auth.currentUser;
    final uid = user?.uid;


    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    //pop the loading circle
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void validator(){
    emailValidator = _emailController.text.trim();
    passwordvalidator = _passwordController.text.trim();
    isValid = EmailValidator.validate(emailValidator);

    if (emailValidator.isEmpty){

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content : Text('Please Enter Email')),
      );
      return;
    }
    if(EmailValidator.validate(emailValidator)) {
      if (isValid = false) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid email')),

        );
        return;
      }
    }

  if (passwordvalidator.isEmpty){
  ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(content : Text('Please enter password')),
  );
  return;
  }
}

@override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/Helping Hand.png',
                  width: 700,
                  height: 200,
                ),


                SizedBox(
                  height: 50,
                ),

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
                              border: InputBorder.none, hintText: 'Email'),
                    ),
                  ),
                ),
                ),
                SizedBox(
                  height: 20,
                ),

                //Password Textfield
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
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Password')),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap : (){
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context){
                              return ForgotPasswordPage();
                            },
                            ),
                          );

                        },
                        child: Text("Forgot Password?", style:
                        GoogleFonts.roboto(color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,fontSize: 20 ),
                        ),
                      )
                    ],
                  ),
                ),


                SizedBox(
                  height: 10,
                ),

                //Sign in button

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signIn,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),

                //Not a member? Register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap : widget.showRegisterPage,
                      child: Text(
                        "Register Now",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );

  }
}
