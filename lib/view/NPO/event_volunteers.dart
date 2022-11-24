import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_volunter/view/NPO/volunteer_info.dart';

class EventVolunteers extends StatefulWidget {
  final String eventTitle;
  const EventVolunteers({super.key, required this.eventTitle});

  @override
  State<EventVolunteers> createState() => _EventVolunteersState();
}

class _EventVolunteersState extends State<EventVolunteers> {
  var EventName;
  late String eventTitle;
  String? uid;
  late String volunteerID;

  Future getVolunteers() async {
    var Firestore = FirebaseFirestore.instance;
    var auth = FirebaseAuth.instance;
    uid = auth.currentUser?.uid;
    QuerySnapshot qn = await Firestore.collection('my_events')
        .doc(eventTitle)
        .collection('appliedVolunteers')
        .get();

    return qn.docs;
  }

  @override
  void initState() {
    eventTitle = widget.eventTitle;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Event Volunteer'),
        ),
        body: Container(
          child: FutureBuilder(
              future: getVolunteers(),
              builder: (BuildContext, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext, index) {
                        return ListTile(
                          style: ListTileStyle.list,
                          selectedTileColor: Colors.grey,
                          minVerticalPadding: 10,
                          title: Text(
                              '${snapshot.data[index].data()["first name"]}' +
                                  '${snapshot.data[index].data()["last name"]}'),
                          subtitle: GestureDetector(
                            onTap: () {

                            },
                            child: Text(
                              'See Details',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          //Forward Arrow
                          trailing: GestureDetector(
                            onTap: () {
                              //To Events Page
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewVolunteers(eventTitle: eventTitle, volunteerID: snapshot.data[index].data()["uid"],)));
                            },
                            child: Icon(
                              Icons.arrow_circle_right,
                              color: Colors.blue,
                            ),
                          ),
                        );
                      });
                } else if (snapshot.data == null) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  //Find a way of displaying this
                  return Center(
                      child: Text(
                    'No topics Created',
                    style: TextStyle(color: Colors.black),
                  ));
                }
              })
          //itembulder takes in a function that builds the list .
          //The itembuilder function(), takes the build context and an index.

          ,
        ));
  }
}
