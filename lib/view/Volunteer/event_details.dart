import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'NPO_list.dart';

class detailspage extends StatefulWidget {
  final String NPO_ID;
  final String EventTitle;
  const detailspage({
    super.key,
    required this.NPO_ID,
    required this.EventTitle,
  });

  @override
  State<detailspage> createState() => _detailspage();
}

class _detailspage extends State<detailspage> {
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
    QuerySnapshot qn = await Firestore.collection("Event")
        .doc(auth.currentUser!.uid)
        .collection("my_events")
        .get();
    return qn.docs;
  }

  showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This action cannot be undone.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              width: 5,
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                //  Application Logic
                var uid = auth.currentUser?.uid;

             getVolunteerDetails()async{
               //Variables to store user data
                String? firstName;
                String? lastName;
                String? email;
                String? age;

              
               //querry users collection to get userdetails
               Firestore.collection('users').doc(uid).get()
                   .then((value) {

                 firstName = value['first name'];
                 lastName = value['last name'];
                 email = value['email'];

                 final volunteerDetails = <String,dynamic>{
                   'first name': firstName,
                   'last name': lastName,
                   'email': email,
                   'uid': uid
                   // 'age': age,
                 };
 
                 //Function to save the doc in firebase
                 FirebaseFirestore.instance
                     .collection('my_events')
                     .doc(eventTitle)
                     .collection('appliedVolunteers')
                     .doc(uid)//volunteer user ID
                     .set(volunteerDetails);

               });



                //create a variable to store the document details
               final volunteeredEvents = <String, dynamic>{
                 'Event_title': eventTitle,
                 'Event_description': eventDescription,
                 'Event_location': eventLocation,
                 'NPO_ID' : NPO_ID

               };

               //Function to get volunteers
               FirebaseFirestore.instance
                   .collection('users')
                   .doc(auth.currentUser?.uid)
                   .collection('application_list')
                   .doc(eventTitle)
                   .set(volunteeredEvents);
             
             }

                getVolunteerDetails();
                setState(() {
                  hasVolunteered = true;
                });

                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Application Successful')));
                // Navigator.pushReplacement(
                //   context,
                //     MaterialPageRoute(
                //       builder: (context)
                //       => NPO_List()));
              },
            ),
          ],
        );
      },
    );
  }

  late String eventLocation;
  late String eventDescription;
  late String neededVolunteers;

  Future getDoc() async {
    await Firestore.collection('Event')
        .doc(NPO_ID)
        .collection('my_events')
        .doc(eventTitle)
        .snapshots()
        .listen((event) {
      eventDescription = event['Event_description'];
      eventLocation = event['Event_location'];
      neededVolunteers = event['Volunteers_no'];
    });
  }

// Widget getEventDetails() =>

  @override
  Widget build(BuildContext context) {
    getDoc();
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
            stream: Firestore.collection('Event')
                .doc(NPO_ID)
                .collection('my_events')
                .doc(eventTitle)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                // get the value of the role field
                final eventDescription = snapshot.data!['Event_description'];
                final eventLocation = snapshot.data!['Event_location'];
                final neededVolunteers = snapshot.data!['Volunteers_no'];

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

                        //Volunteer No

                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text(
                              'Needed Volunteers',
                              style: GoogleFonts.openSans(fontSize: 24),
                            ),
                          ),
                        ),

                        SizedBox(height: 10),
                        //course Title Edit Text
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: CupertinoTextField(
                            placeholder: neededVolunteers,
                            placeholderStyle: TextStyle(color: Colors.black),
                            readOnly: true,
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(height: 45),

                        //Apply Button
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: Center(
                            child: CupertinoButton(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.blue,
                                child: Text(
                                  'Apply',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () => {
                                  if(hasVolunteered == false){
                                    showMyDialog()
                                  }else{
                                Fluttertoast.showToast(
                                msg: "Application already made",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0
                            )
                                  }
                                 }),
                          ),
                        ),

                        SizedBox(
                          height: 25,
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
