import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:core';
import 'package:email_validator/email_validator.dart';

import 'Login.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late bool _passwordVisible;
  late bool _cpasswordVisible;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _textFormfieldController = TextEditingController();

  late String emailValidator;
  late String passwordValidator;
  late String confirmPasswordValidator;
  late String firstNameValidator;
  late String lastNameValidator;
  late String ageValidator;
  late bool isValid;
  var auth = FirebaseAuth.instance;

  GroupController controller = GroupController();

  late final String selectedValue;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();

    super.dispose();
  }

  void validator() {
    emailValidator = _emailController.text.trim();
    passwordValidator = _passwordController.text.trim();
    isValid = EmailValidator.validate(emailValidator);
    confirmPasswordValidator = _confirmPasswordController.text.trim();
    firstNameValidator = _firstNameController.text.trim();
    lastNameValidator = _lastNameController.text.trim();
    ageValidator = _ageController.text.trim();

    if (firstNameValidator.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please Enter Your First Name')),
      );
      return;
    }
    if (lastNameValidator.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please Enter Your Last Name')),
      );
      return;
    }
    if (ageValidator.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please Enter your age')),
      );
      return;
    }

    if (emailValidator.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please Enter Email')),
      );
      return;
    }
    if (EmailValidator.validate(emailValidator)) {
      if (isValid = false) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid email')),
        );
        return;
      }
    }
    if (passwordValidator.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter password')),
      );
      return;
    }
    if (passwordValidator.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Minimum Password Length of 6 required')),
      );
      return;
    }
    if (confirmPasswordValidator.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please Confirm Password')),
      );
      return;
    }
  }

  Future signUp() async {
    validator();
    //create user
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      // add user details
      addUserDetails(
          _firstNameController.text.trim(),
          _lastNameController.text.trim(),
          _emailController.text.trim(),
          int.parse(
            _ageController.text.trim(),
          ));

      //add role
      addRole(selectedValue);
    }
  }

  Future addUserDetails(
      String firstName, String lastName, String email, int age) async {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'first name': firstName,
      'last name': lastName,
      'email': email,
      'role': selectedValue,
      'uid': uid
    });
  }

  Future addRole(String selectedValue) async {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'role': selectedValue,
    });
  }

  bool passwordConfirmed() {
    if (_confirmPasswordController.text.trim() ==
        _passwordController.text.trim()) {
      return true;
    } else
      return false;
  }

  @override
  void initState() {
    _passwordVisible = false;
    _cpasswordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),

                //First Name Textfield
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
                          controller: _firstNameController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'First Name')),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                //lastName Textfield
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
                          controller: _lastNameController,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Last Name')),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                //age Textfield
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
                          controller: _ageController,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Age')),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
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
                              border: InputBorder.none, hintText: 'Email')),
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
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                              border: InputBorder.none,
                              hintText: 'Password')),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //Confirm Password Textfield
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
                          controller: _confirmPasswordController,
                          obscureText: !_cpasswordVisible,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _cpasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _cpasswordVisible = !_cpasswordVisible;
                                  });
                                },
                              ),
                              border: InputBorder.none,
                              hintText: 'Confirm Password')),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                //Who are you
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'What brings you here?',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //Role Checkbox
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: SimpleGroupedCheckbox<String>(
                    onItemSelected: (value) {
                      setState(() {
                        print(value.toString());
                        selectedValue = value.toString();
                      });
                    },
                    controller: controller,
                    itemsTitle: ["I am Volunteering", "I am Registering a NPO"],
                    values: ['Volunteer', 'NPO'],
                    groupStyle: GroupStyle(
                        activeColor: Colors.blue,
                        itemTitleStyle: TextStyle(fontSize: 13)),
                    checkFirstElement: false,
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                //Sign up button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signUp,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: Text(
                          "Sign Up",
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
                      "I have an account!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: Text(
                        "Login Now",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
