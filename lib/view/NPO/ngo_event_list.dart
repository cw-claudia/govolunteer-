import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AddEvent.dart';
import 'event_volunteers.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  //create future variable
  late Future _EventData;
  final auth = FirebaseAuth.instance;
  Future getEvents() async {
    var Firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await Firestore.collection("Event")
        .doc(auth.currentUser!.uid)
        .collection("my_events")
        .get();

    return qn.docs;
  }

  void initState() {
    super.initState();
    _EventData = getEvents();
  }


  Widget deleteBgItem() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20),
      color: Colors.amber,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton:
        FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context)=>AddEvent())); },
          child:Icon(Icons.add) ,),
        appBar: AppBar(
          title: const Text('Events List',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
        ),
        body: Container(
            child: FutureBuilder(
                future: getEvents(),
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
                                  leading: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EventVolunteers(
                                                      eventTitle: snapshot
                                                              .data[index]
                                                              .data()[
                                                          'Event_title'],
                                                    )));
                                      },
                                      child: Icon(Icons.event, size: 45)),
                                  title: Text(snapshot.data[index]
                                      .data()['Event_title']),
                                  subtitle: Text(snapshot.data[index]
                                      .data()['Event_location']),
                                  trailing: Column(
                                    children: [
                                      Text('Volunteers \n'
                                              'needed : ' +
                                          snapshot.data[index]
                                              .data()['Volunteers_no']),



                                    ],
                                  ),
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
