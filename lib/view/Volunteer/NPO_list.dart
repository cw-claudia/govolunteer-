import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'event_list.dart';

class NPO_List extends StatefulWidget {
  const NPO_List({Key? key}) : super(key: key);

  @override
  State<NPO_List> createState() => _NPO_List();
}

class _NPO_List extends State<NPO_List> {
  var EventName;
  Future getNpos() async {
    String? role = "NPO";
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection('users')
        .where("role", isEqualTo: role)
        .get();

    return qn.docs;
  }

  String? uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('NEARBY NPOs'),
        ),
        body: Container(
          child: FutureBuilder(
              future: getNpos(),
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
                            onTap: () {},
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
                                      builder: (context) => ViewEvents(
                                            userID: snapshot.data[index]
                                                .data()["uid"],
                                            EventName: snapshot.data[index]
                                                .data()["uid"],
                                          )));
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
