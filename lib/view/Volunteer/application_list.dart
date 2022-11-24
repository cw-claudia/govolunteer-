import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Apply/appliedEventDetails.dart';
import 'event_details.dart';

class ApplicationList extends StatefulWidget {
  const ApplicationList({super.key});

  @override
  State<ApplicationList> createState() => _ApplicationListState();
}

class _ApplicationListState extends State<ApplicationList> {

  var auth =  FirebaseAuth.instance;
  Future getApplications() async {
    var uid = auth.currentUser!.uid;
    var Firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await Firestore.collection("users")
        .doc(uid)
        .collection("application_list")
        .get();

    return qn.docs;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
      onTap: getApplications,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.refresh),
      ))
        ],
        title: Text('My Applications'),

      ),
 body:  Container(
     child: FutureBuilder(
         future: getApplications(),
         builder:
             (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
           if (snapshot.hasData && snapshot.data != null) {
             return ListView.builder(
                 itemCount: snapshot.data.length,
                 itemBuilder: (BuildContext, index) {
                   return Card(
                     child: Column(
                       children: [
                         ListTile(
                           minVerticalPadding: 12,
                           focusColor: Colors.blue,
                           leading: Icon(Icons.event, size: 45),
                           title: Text(snapshot.data[index]
                               .data()['Event_title']),
                           subtitle: Text(snapshot.data[index]
                               .data()['Event_location']),
                           trailing: IconButton(
                             icon: Icon(Icons.arrow_forward),
                             onPressed: () {
                               Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                       builder: (context) => appliedEvent(
                                         NPO_ID: snapshot.data[index]
                                             .data()['NPO_ID'],
                                         EventTitle: snapshot
                                             .data[index]
                                             .data()['Event_title'],
                                       )));
                             },
                           ),
                           onTap: () {
                             // Navigator.push(
                             //     context,
                             //     MaterialPageRoute(
                             //         builder: (context) => detailspage(
                             //           NPO_ID: userID,
                             //           EventTitle: snapshot
                             //               .data[index]
                             //               .data()['Event_title'],
                             //         )));
                           },
                         ),
                       ],
                     ),
                   );
                 });
           } else {
             return Center(
               child: Text(
                 'No Events created',
                 style: TextStyle(color: Colors.black),
               ),
             );
           }
         })));
  }
}
