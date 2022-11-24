//

import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_volunter/utils/user_preferences.dart';
import 'package:go_volunter/widget/appbar_widget.dart';
import 'package:go_volunter/widget/button_widget.dart';
import 'package:go_volunter/widget/numbers_widget.dart';
import 'package:go_volunter/widget/profile_widget.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';

class NGOProfile extends StatefulWidget {
  const NGOProfile({Key? key}) : super(key: key);

  @override
  State<NGOProfile> createState() => _NGOProfileState();
}

class _NGOProfileState extends State<NGOProfile> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text('Signed In as: '+ user.email!,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(onPressed: (){
                  FirebaseAuth.instance.signOut();
                },
                  color:Colors.blue,
                  child: Text('Sign Out', style: TextStyle(
                      color: Colors.white
                  ),),),
              ),
            )
          ],
        ),

      ),
    );
  }
}
