import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference formCollection =
      Firestore.instance.collection('meetingforms');

  Future<void> storeNewForm(
      String displayName,
      String menteeName,
      String itemDiscussed,
      DateTime selectedDate,
      String programme,
      String intake,
      String currentSemester,
      String recipientEmail,
      bool agreement) async {
    FirebaseUser result = await FirebaseAuth.instance.currentUser();
    String user = result.uid;
    return await formCollection.document(uid).setData({
      'uid': user,
      'date&time': selectedDate,
      'menteeName': menteeName,
      'mentorName': displayName,
      'item_discussed': itemDiscussed,
      'enrolled_programme': programme,
      'intake': intake,
      'currentSemester': currentSemester,
      'menteeEmail': recipientEmail,
      'agreement': agreement,
    });
  }
}
