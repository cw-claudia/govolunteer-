import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/Event_Model.dart';


import 'ngo_event_list.dart';


class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {

  final _eventTitleController = TextEditingController();
  final _eventLocationController = TextEditingController();
  final _eventDescriptionController = TextEditingController();
  final _voluntererNoController = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  late final String event_title;
  late final String event_location;
  late final String event_description;
  late final String volunteer_no;

  @override
  void dispose() {
    _eventTitleController.dispose();
    _eventLocationController.dispose();
    _eventDescriptionController.dispose();
    _voluntererNoController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Add Event',
          style: GoogleFonts.barlowCondensed(fontSize: 40),),
        centerTitle: true,
      ),
      body: SafeArea(
          child:SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height:10),

                  //Event Title

                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text('Event Title',style:
                      GoogleFonts.openSans(fontSize: 24),),
                    ),
                  ),
                  SizedBox(height:10),
                  //Event Title Edit Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child:  CupertinoTextField(

                      controller:_eventTitleController
                      ,
                      maxLines: 1,)
                    ,),
                  SizedBox(height:10),
                  //Event Title
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text('Event Location',style:
                      GoogleFonts.openSans(fontSize: 24),),
                    ),
                  ),

                  SizedBox(height:10),
                  //Event Title Edit Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child:  CupertinoTextField(
                      controller: _eventLocationController,
                      maxLines: 1,)
                    ,),
                  SizedBox(height:10),
                  //Event Description
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text('Event Description',style:
                      GoogleFonts.openSans(fontSize: 24),),
                    ),
                  ),
                  SizedBox(height: 10,),

                  //Event Description Edit Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child:  CupertinoTextField(
                      controller: _eventDescriptionController,
                      maxLines: 7,

                    ),
                  ),

                  //Volunteer No

                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text('No Of Voulunteers',style:
                      GoogleFonts.openSans(fontSize: 24),),
                    ),
                  ),

                  SizedBox(height:10),
                  //course Title Edit Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child:  CupertinoTextField(
                      controller: _voluntererNoController,
                      maxLines: 1,)
                    ,),
                  SizedBox(height: 45),

                  //Create Event Button
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CupertinoButton(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.blue,
                          child: Text('Create',style: TextStyle(color: Colors.white),),
                          onPressed: ()=>{
                            savetofirebase(),
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder:
                          (context)=>EventsPage()))


                    }),
                  ),
                  ),


                  SizedBox(height: 25,),

                ],
              ),
            ),
          )
      ),
    );
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future savetofirebase() async {
    final User? user = auth.currentUser;
    final uid = user?.uid;

    event_title = _eventTitleController.text.trim();
    event_location =  _eventLocationController.text.trim();
    event_description = _eventDescriptionController.text.trim();
    volunteer_no= _voluntererNoController.text.trim();

    final event = Event(
      Event_title:event_title ,
      Event_location: event_location,
      Event_description: event_description,
      Volunteers_no:volunteer_no ,
      IsEvent: true,

    );

    final docRef = FirebaseFirestore.instance
        .collection("Event").doc(uid).
    collection("my_events")
        .withConverter(
      fromFirestore: Event.fromFirestore,
      toFirestore: (Event event, options) => event.toFirestore(),
    )
        .doc(event_title);
    await docRef.set(event);

    Fluttertoast.showToast(
        msg: "Event Created Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
