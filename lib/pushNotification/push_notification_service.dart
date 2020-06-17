import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Future initialise() async {
    _firebaseMessaging.configure(
        //called when app is active
        onMessage: (Map<String, dynamic> message) async {
      print('onMessage:$message');
    },
        //called when app is closed and open with push notification
        onLaunch: (Map<String, dynamic> message) async {
      print('onLaunch:$message');
    },
        //called when app is open in the background
        onResume: (Map<String, dynamic> message) async {
      print('onResume:$message');
    });
  }
}
