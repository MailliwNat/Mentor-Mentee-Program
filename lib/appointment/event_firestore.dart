import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Appointments {
  final title;
  final description;
  final menteeName;
  final selectedDate;

  Appointments(
      {this.title, this.description, this.menteeName, this.selectedDate});
}

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference formCollection =
      Firestore.instance.collection('appointments');

  Future<void> storeNewAppointment(
      String title,
      String description,
      String menteeName,
      DateTime selectedDate,
      String mentorName,
      var menteeEmail,
      String mentorEmail) async {
    FirebaseUser result = await FirebaseAuth.instance.currentUser();
    String user = result.uid;
    return await formCollection.document(uid).setData({
      'uid': user,
      'mentorName': mentorName,
      'appointment_topic': title,
      'description': description,
      'menteeName': menteeName,
      'date&time': selectedDate,
      'mentorEmail': mentorEmail,
      'menteeEmail': menteeEmail,
    });
  }
}
