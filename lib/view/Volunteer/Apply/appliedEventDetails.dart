import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';



class appliedEvent extends StatefulWidget {
  final String NPO_ID;
  final String EventTitle;
  const appliedEvent({
    super.key,
    required this.NPO_ID,
    required this.EventTitle,
  });

  @override
  State<appliedEvent> createState() => _appliedEvent();
}

class _appliedEvent extends State<appliedEvent> {
  late String NPO_ID;
  late String eventTitle;
  late bool hasVolunteered;
  @override
  void initState() {
    NPO_ID = widget.NPO_ID;
    eventTitle = widget.EventTitle;
    hasVolunteered = false;

    super.initState();
  }


  var Firestore = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;
  Future getEvents() async {
    var uid = auth.currentUser!.uid;
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
          title: Text(
            'Event Details',
            style: GoogleFonts.barlowCondensed(fontSize: 40),
          ),
          centerTitle: true,
          leading: BackButton(),
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: Firestore.collection('users')
                .doc(auth.currentUser?.uid)
                .collection('application_list')
                .doc(eventTitle)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                // get the value of the role field
                final eventDescription = snapshot.data!['Event_description'];
                final eventLocation = snapshot.data!['Event_location'];


                return SafeArea(
                    child: SingleChildScrollView(
                      child: Form(
                        child: Column(
                          children: [
                            //Event Title
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                                child: Text(
                                  'Event Title',
                                  style: GoogleFonts.openSans(fontSize: 24),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            //Event Title Edit Text
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0),
                              child: CupertinoTextField(
                                placeholder: eventTitle,
                                placeholderStyle: TextStyle(color: Colors.black),
                                readOnly: true,
                                maxLines: 1,
                              ),
                            ),
                            SizedBox(height: 10),
                            //Event Title
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                                child: Text(
                                  'Event Location',
                                  style: GoogleFonts.openSans(fontSize: 24),
                                ),
                              ),
                            ),

                            SizedBox(height: 10),
                            //Event location Edit Text
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0),
                              child: CupertinoTextField(
                                placeholder: eventLocation,
                                placeholderStyle: TextStyle(color: Colors.black),
                                readOnly: true,
                                maxLines: 1,
                              ),
                            ),
                            SizedBox(height: 10),
                            //Event Description
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                                child: Text(
                                  'Event Description',
                                  style: GoogleFonts.openSans(fontSize: 24),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            //Event Description Edit Text
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0),
                              child: CupertinoTextField(
                                placeholder: eventDescription,
                                placeholderStyle: TextStyle(color: Colors.black),
                                readOnly: true,
                                maxLines: 7,
                              ),
                            ),


                          ],
                        ),
                      ),
                    ));
              } else
                return Container(
                  child: Center(child: Text('Network Error')),
                );
            }));
  }
}
