import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  late final String? Event_title;
  late final String? Event_location;
  late final String? Event_description;
  late final String? Volunteers_no;
  late final bool? IsEvent;

  Event({
    this.Event_title,
    this.Event_location,
    this.Event_description,
    this.Volunteers_no,
    this.IsEvent

  });
  factory Event.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Event(
      Event_title: data?['Event_title'],
      Event_location: data?['Event_location'],
      Event_description: data?['Event_description'],
      IsEvent: data?['IsEvent'],
      Volunteers_no: data?['Volunteers_no'],

    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (Event_title != null) "Event_title": Event_title,
      if (Event_location != null) "Event_location": Event_location,
      if (Event_description != null) "Event_description": Event_description,
      if (IsEvent != null) "Volunteers_no": IsEvent,
      if (Volunteers_no != null) "Volunteers_no": Volunteers_no,

    };
  }

}