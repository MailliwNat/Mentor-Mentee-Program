import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentor_program/homepage.dart';
import 'package:mentor_program/services/usermanagement.dart';
import 'package:mentor_program/shared/constants.dart';

class MentorInfoPage extends StatefulWidget {
  @override
  _MentorInfoPageState createState() => _MentorInfoPageState();
}

class _MentorInfoPageState extends State<MentorInfoPage> {
  final _formKey = GlobalKey<FormState>();
  String interest1;
  String interest2;
  String hobby1;
  String hobby2;
  String role;
  String password;
  String education;
  String researchInterest;

  Future updateInterest1(String interest1) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var userInfo = new UserUpdateInfo();
    await user.updateProfile(userInfo).then((value) {
      FirebaseAuth.instance.currentUser().then((user) {
        Firestore.instance
            .collection('/staff')
            .where('uid', isEqualTo: user.uid)
            .getDocuments()
            .then((doc) {
          Firestore.instance
              .document('/staff/${doc.documents[0].documentID}')
              .updateData({'interest1': interest1});
        });
      });
    });
  }

  Future updateInterest2(String interest2) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var userInfo = new UserUpdateInfo();
    await user.updateProfile(userInfo).then((value) {
      FirebaseAuth.instance.currentUser().then((user) {
        Firestore.instance
            .collection('/staff')
            .where('uid', isEqualTo: user.uid)
            .getDocuments()
            .then((doc) {
          Firestore.instance
              .document('/staff/${doc.documents[0].documentID}')
              .updateData({'interest2': interest2});
        });
      });
    });
  }

  Future updateHobby1(String hobby1) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var userInfo = new UserUpdateInfo();
    await user.updateProfile(userInfo).then((value) {
      FirebaseAuth.instance.currentUser().then((user) {
        Firestore.instance
            .collection('/staff')
            .where('uid', isEqualTo: user.uid)
            .getDocuments()
            .then((doc) {
          Firestore.instance
              .document('/staff/${doc.documents[0].documentID}')
              .updateData({'hobby1': hobby1});
        });
      });
    });
  }

  Future updateHobby2(String hobby2) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var userInfo = new UserUpdateInfo();
    await user.updateProfile(userInfo).then((value) {
      FirebaseAuth.instance.currentUser().then((user) {
        Firestore.instance
            .collection('/staff')
            .where('uid', isEqualTo: user.uid)
            .getDocuments()
            .then((doc) {
          Firestore.instance
              .document('/staff/${doc.documents[0].documentID}')
              .updateData({'hobby2': hobby2});
        });
      });
    });
  }

  Future updateresearchInterest(String researchInterest) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var userInfo = new UserUpdateInfo();
    await user.updateProfile(userInfo).then((value) {
      FirebaseAuth.instance.currentUser().then((user) {
        Firestore.instance
            .collection('/staff')
            .where('uid', isEqualTo: user.uid)
            .getDocuments()
            .then((doc) {
          Firestore.instance
              .document('/staff/${doc.documents[0].documentID}')
              .updateData({'researchInterest': researchInterest});
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()))),
        title: Text('Edit Information'),
        centerTitle: true,
      ),
      body: new SingleChildScrollView(
        child: new Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: new Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Research Interest'),
                      validator: (value) =>
                          value.length != 0 ? null : 'Enter interest',
                      onChanged: (value) {
                        setState(() => researchInterest = value);
                      }),
                  TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Interest 1'),
                      validator: (value) =>
                          value.length != 0 ? null : 'Enter interest',
                      onChanged: (value) {
                        setState(() => interest1 = value);
                      }),
                  TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Interest 2'),
                      validator: (value) =>
                          value.length != 0 ? null : 'Enter interest',
                      onChanged: (value) {
                        setState(() => interest2 = value);
                      }),
                  TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Hobby 1'),
                      validator: (value) =>
                          value.length != 0 ? null : 'Enter hobby',
                      onChanged: (value) {
                        setState(() => hobby1 = value);
                      }),
                  TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Hobby 2'),
                      validator: (value) =>
                          value.length != 0 ? null : 'Enter hobby',
                      onChanged: (value) {
                        setState(() => hobby2 = value);
                      }),
                  SizedBox(height: 10.0),
                  RaisedButton(
                      child: Text('Set Information'),
                      color: Colors.blue,
                      textColor: Colors.white,
                      elevation: 7.0,
                      onPressed: () {
                        _formKey.currentState.validate();
                        if (_formKey.currentState.validate()) {
                          FirebaseAuth.instance.currentUser().then((user) {
                            updateresearchInterest(researchInterest);
                            updateInterest1(interest1);
                            updateInterest2(interest2);
                            updateHobby1(hobby1);
                            updateHobby2(hobby2);
                          }).then((user) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HomePage()));
                          });
                        }
                      })
                ],
              )),
        ),
      ),
    );
  }
}
