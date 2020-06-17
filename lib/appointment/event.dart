import 'package:firebase_helpers/firebase_helpers.dart';

DatabaseService<EventModel> eventDBS = DatabaseService<EventModel>(
    "appointments",
    fromDS: (uid, data) => EventModel.fromDS(uid, data),
    toMap: (event) => event.toMap());

class EventModel extends DatabaseItem {
  String uid;
  String title;
  String description;
  DateTime appointment_date;

  EventModel({
    this.uid,
    this.title,
    this.description,
    this.appointment_date,
  }) : super(uid);

  factory EventModel.fromMap(Map data) {
    return EventModel(
      title: data['title'],
      description: data['description'],
      appointment_date: data['appointment_date'],
    );
  }

  factory EventModel.fromDS(String uid, Map<String, dynamic> data) {
    return EventModel(
      uid: uid,
      title: data['title'],
      description: data['description'],
      appointment_date: data['appointment_date'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "title": title,
      "description": description,
      "appointment_date": appointment_date,
    };
  }
}
