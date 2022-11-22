// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// // on the authentication page
// var myUser = UserModel().obs;

// getUserInfo() {
//   String uid = FirebaseAuth.instance.currentUser!.uid;
//   FirebaseFirestore.instance
//       .collection('users')
//       .doc(uid)
//       .snapshots()
//       .listen((event) {});
//   myUser.value = UserModel.fromJson(event.data()!);
// }
// //model folder user_model.dart represents class user

// class UserModel {
//   String? name;
//   String? email;
//   String? age;
//   String? location;
//   String? image;

//   UserModel({this.name,this.email,this.age,this.location,this.image});

//   UserModel.fromJson(Map<String, dynamic> json) {
//     name = json['first name'];
//     email = json['email'];
//     age = json['age'];
//     location = json['location'];
//     image = json['image'];
//   }
// }

// //on homepage or where profile will be seen 
// AuthController authController = Get.find<AuthController>();
// //import library 
// authController.getUserInfo();

// //widget for the profile
// Widget buildProfileTile(){
//   return Positioned(
//     top: 0,
//     left: 0,
//     right: 0,
//     child: Center(
//       child: Obx(() =>authController.myUser.value.name == null? Center(child: CircularProgressIndicator,) Container(
//         width: Get.width,
//         height: Get.width*0.5,
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         decoration:BoxDecoration(
//           color: Colors.white70
//         ),
//         child: Row(),
        
//       ),
//     ),
//     ),
//   );
// }
