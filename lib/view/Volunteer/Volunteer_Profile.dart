import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Volunteer_Profile extends StatefulWidget {
  const Volunteer_Profile({Key? key}) : super(key: key);

  @override
  State<Volunteer_Profile> createState() => _Volunteer_ProfileState();
}

class _Volunteer_ProfileState extends State<Volunteer_Profile> {
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
