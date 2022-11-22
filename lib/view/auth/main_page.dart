import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../NPO/NGO_bottom_NavBar.dart';
import '../Volunteer/Volunteer_bottom_nav.dart';
import 'auth_helper.dart';
import 'auth_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            UserHelper.saveUser(snapshot.data);
            return StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(snapshot.data?.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    // get the value of the role field

                    final userRole = snapshot.data!['role'];
                    if (userRole != 'Volunteer') {
                      return NGOBottomNav();
                    } else {
                      return VolunteerBottomNav();
                    }
                    //then extract the specific fields
                  }
                  return Material(
                      child: Center(
                    child: CircularProgressIndicator(),
                  ));
                });
          }
          return AuthPage();
        },
      ),
    );
  }
}
