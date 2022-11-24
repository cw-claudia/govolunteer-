import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_volunter/view/Volunteer/event_details.dart';

class ViewEvents extends StatefulWidget {
  final String userID;
  final String EventName;
  const ViewEvents({Key? key, required this.userID, required this.EventName})
      : super(key: key);

  @override
  State<ViewEvents> createState() => _ViewEventsState();
}

class _ViewEventsState extends State<ViewEvents> {
  late String userID;
  //create future variable
  late Future _EventData;
  final auth = FirebaseAuth.instance;
  Future getEvents() async {
    var Firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await Firestore.collection("Event")
        .doc(userID)
        .collection("my_events")
        .get();

    return qn.docs;
  }

  void initState() {
    super.initState();
    userID = widget.userID;
    _EventData = getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                              builder: (context) => detailspage(
                                                    NPO_ID: userID,
                                                    EventTitle: snapshot
                                                        .data[index]
                                                        .data()['Event_title'],
                                                  )));
                                    },
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => detailspage(
                                                  NPO_ID: userID,
                                                  EventTitle: snapshot
                                                      .data[index]
                                                      .data()['Event_title'],
                                                )));
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
