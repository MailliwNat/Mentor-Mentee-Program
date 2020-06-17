import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mentor_program/homepage.dart';
import 'package:mentor_program/loginpage.dart';

class StudentData {
  final String uid;
  final String email;
  final String role;
  final String mentorName;
  final String menteeName;
  final String password;

  StudentData(
      {this.password,
      this.uid,
      this.email,
      this.role,
      this.mentorName,
      this.menteeName});
}

class MentorData {
  final String uid;
  final String email;
  final String displayName;
  final String menteeName;
  final String photoUrl;
  final String role;
  final String mentees;
  final String password;

  MentorData(
      {this.uid,
      this.password,
      this.displayName,
      this.menteeName,
      this.photoUrl,
      this.role,
      this.email,
      this.mentees});
}

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference staffCollection =
      Firestore.instance.collection('staff');

  userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return MentorData(
        photoUrl: doc.data['photoUrl'],
        displayName: doc.data['displayName'],
        email: doc.data['email'],
      );
    }).toList();
  }

  userDataFromSnapshot(DocumentSnapshot snapshot) {
    return MentorData(
        uid: uid,
        email: snapshot.data['email'],
        displayName: snapshot.data['displayName'],
        photoUrl: snapshot.data['photoUrl']);
  }

  mentorsData() {
    return staffCollection.snapshots().map(userListFromSnapshot);
  }

  userData() {
    return staffCollection.document(uid).snapshots().map(userDataFromSnapshot);
  }
}

class User {
  final String uid;

  User({this.uid});
}

class UserManagement {
  String displayName;
  var photoUrl;
  String role;
  String mentorName;
  String studentName;
  String mentees;
  String menteeName;
  var mentorProfilePic;
  var menteeEmail;
  String email;
  var uid;
  var password;
  String programme;
  var interest1;
  var education;
  var hobby1;
  var hobby2;
  var interest2;

  Future<String> getCurrentUID() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

  storeNewMentor(user, context, String role, String password, String education,
      String interest1, String interest2, String hobby1, String hobby2) {
    Firestore.instance.collection('/staff').add({
      'email': user.email,
      'password': password,
      'uid': user.uid,
      'displayName': user.displayName,
      'photoUrl': user.photoUrl,
      'role': role,
      'interest1': interest1,
      'education': education,
      'hobby1': hobby1,
      'hobby2': hobby2,
      'interest2': interest2,
    }).then((value) {
      Navigator.of(context).pushReplacementNamed('/selectpic');
    }).catchError((e) {
      print(e);
    });
  }

  storeNewAdmin(user, context, String role, String password) {
    Firestore.instance.collection('/staff').add({
      'email': user.email,
      'password': password,
      'uid': user.uid,
      'role': role,
    }).then((value) {
      Navigator.of(context).pop();
    }).catchError((e) {
      print(e);
    });
  }

  storeNewMentee(user, context, String role, String mentorName,
      String menteeName, String password, String programme, var intake) {
    Firestore.instance.collection('/student').add({
      'email': user.email,
      'password': password,
      'uid': user.uid,
      'menteeName': menteeName,
      'role': role,
      'mentorName': mentorName,
      'programme': programme,
      'intake': intake,
    }).then((value) {
      Navigator.of(context).pushReplacementNamed('/menteehomepage');
    }).catchError((e) {
      print(e);
    });
  }

  Widget handleAuth() {
    return new StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          }
          return LoginPage();
        });
  }

  authorizeAccess(BuildContext context) {
    FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance
          .collection('/staff')
          .where('uid', isEqualTo: user.uid)
          .getDocuments()
          .then((docs) {
        if (docs.documents[0].exists) {
          if (docs.documents[0].data['role'] == 'Admin') {
            Navigator.of(context).pushReplacementNamed('/adminonly');
          }
        }
      });
    });
  }

  authorizeMentorAccess(BuildContext context) {
    FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance
          .collection('/staff')
          .where('uid', isEqualTo: user.uid)
          .getDocuments()
          .then((docs) {
        if (docs.documents[0].exists) {
          if (docs.documents[0].data['role'] == 'Mentor') {
            Navigator.of(context).pushReplacementNamed('/homepage');
          }
        }
      });
    });
  }

  authorizeNormalAccess(BuildContext context) {
    FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance
          .collection('/student')
          .where('uid', isEqualTo: user.uid)
          .getDocuments()
          .then((docs) {
        if (docs.documents[0].exists) {
          if (docs.documents[0].data['role'] == 'Mentee') {
            Navigator.of(context).pushReplacementNamed('/menteehomepage');
          }
        }
      });
    });
  }

  authorizeButton(BuildContext context) {
    FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance
          .collection('/staff')
          .where('uid', isEqualTo: user.uid)
          .getDocuments()
          .then((docs) {
        if (docs.documents[0].exists) {
          if (docs.documents[0].data['role'] == 'Mentor') {
            Navigator.of(context).pushReplacementNamed('/selectpic');
          }
        }
      });
    });
  }

  Future updateProfilePic(picUrl) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var userInfo = new UserUpdateInfo();
    userInfo.photoUrl = picUrl;

    await user.updateProfile(userInfo).then((val) {
      FirebaseAuth.instance.currentUser().then((user) {
        Firestore.instance
            .collection('/staff')
            .where('uid', isEqualTo: user.uid)
            .getDocuments()
            .then((docs) {
          Firestore.instance
              .document('/staff/${docs.documents[0].documentID}')
              .updateData({
            'photoUrl': FieldValue.arrayUnion([picUrl])
          }).catchError((e) {
            print(e);
          });
        }).catchError((e) {
          print(e);
        });
      }).catchError((e) {
        print(e);
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future updateNickName(String newName) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var userInfo = new UserUpdateInfo();
    userInfo.displayName = newName;
    await user.updateProfile(userInfo).then((val) {
      FirebaseAuth.instance.currentUser().then((user) {
        Firestore.instance
            .collection('/staff')
            .where('uid', isEqualTo: user.uid)
            .getDocuments()
            .then((doc) {
          Firestore.instance
              .document('/staff/${doc.documents[0].documentID}')
              .updateData({'displayName': newName}).then((val) {
            print('updated');
          }).catchError((e) {
            print(e);
          });
        });
      });
    });
  }

  Future<void> updateMenteeEmailList(String mentorName, String email) async {
    await Firestore.instance
        .collection('/staff')
        .where('displayName', isEqualTo: mentorName)
        .getDocuments()
        .then((doc) {
      Firestore.instance
          .document('/staff/${doc.documents[0].documentID}')
          .updateData({
        'mentees': FieldValue.arrayUnion([email])
      }).then((val) {
        print('Updated');
      }).catchError((e) {
        print(e);
      });
    });
  }

  Future<void> updateMenteeNameList(
      String mentorName, String menteeName) async {
    await Firestore.instance
        .collection('/staff')
        .where('displayName', isEqualTo: mentorName)
        .getDocuments()
        .then((doc) {
      Firestore.instance
          .document('/staff/${doc.documents[0].documentID}')
          .updateData({
        'menteeName': FieldValue.arrayUnion([menteeName])
      }).then((val) {
        print('Updated');
      }).catchError((e) {
        print(e);
      });
    });
  }

  Future<void> updateMenteeListEmail(String mentorName, String email) async {
    await Firestore.instance
        .collection('/staff')
        .where('displayName', isEqualTo: mentorName)
        .getDocuments()
        .then((doc) {
      Firestore.instance
          .document('/staff/${doc.documents[0].documentID}')
          .updateData({
        'menteeEmail': FieldValue.arrayUnion([email])
      }).then((val) {
        print('Updated');
      }).catchError((e) {
        print(e);
      });
    });
  }

  Future<void> updateMenteeListName(
      String mentorname, String menteeName) async {
    await Firestore.instance
        .collection('/staff')
        .where('displayName', isEqualTo: mentorName)
        .getDocuments()
        .then((doc) {
      Firestore.instance
          .document('/staff/${doc.documents[0].documentID}')
          .updateData({
        'mentees': FieldValue.arrayUnion([menteeName])
      }).then((val) {
        print('Updated');
      }).catchError((e) {
        print(e);
      });
    });
  }
}
