import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mentor_program/shared/constants.dart';
import 'services/usermanagement.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MenteeSignUp extends StatefulWidget {
  @override
  _MenteeSignUpState createState() => _MenteeSignUpState();
}

class _MenteeSignUpState extends State<MenteeSignUp> {
  final _formKey = GlobalKey<FormState>();
  UserManagement userManagement = new UserManagement();
  String email;
  String password;
  String menteeName;
  String error;
  String role;
  String selectedRole;
  String admin;
  String mentorName;
  bool loading = false;
  String programme;
  String intake;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('/staff')
            .orderBy('displayName')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new SingleChildScrollView(
              child: new Container(
                  padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
                  child: new Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // SizedBox(height: 20.0),
                          Text(
                            'Register Mentee',
                            style: TextStyle(
                                fontSize: 30.0,
                                fontStyle: FontStyle.italic,
                                fontFamily: 'BalooTamma'),
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Email'),
                              validator: (value) =>
                                  value.isEmpty ? 'Enter an email' : null,
                              onChanged: (value) {
                                setState(() => email = value);
                              }),
                          TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Password'),
                              validator: (value) => value.length < 6
                                  ? 'Enter a password 6 characters or longer'
                                  : null,
                              obscureText: true,
                              onChanged: (value) {
                                setState(() => password = value);
                              }),
                          TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Mentee\'s Full Name'),
                              validator: (value) => value.length != 0
                                  ? null
                                  : 'Enter mentee\'s name',
                              onChanged: (value) {
                                setState(() => menteeName = value);
                              }),
                          DropdownButtonFormField<String>(
                            isExpanded: true,
                            decoration: textInputDecoration.copyWith(
                              hintText: 'Programme',
                            ),
                            validator: (value) =>
                                value == null ? 'Programme' : null,
                            onChanged: (value) {
                              setState(() => programme = value);
                            },
                            items: [
                              'BSc (Hons) in Computer Science',
                              'BSc (Hons) Information Technology',
                              'BSc (Hons) Information Technology (Computer Networking and Security)',
                              'BSc (Hons) Information Systems',
                              'BSc (Hons) Information Systems (Business Analytics)',
                              'Bachelor of Software Engineering (Hons)'
                            ].map<DropdownMenuItem<String>>((String programme) {
                              return DropdownMenuItem<String>(
                                value: programme,
                                child: Text(
                                  programme,
                                  overflow: TextOverflow.clip,
                                ),
                              );
                            }).toList(),
                          ),
                          TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Intake Year and Month'),
                              validator: (value) =>
                                  value.isEmpty ? 'Enter Intake Year' : null,
                              onChanged: (value) {
                                setState(() => intake = value);
                              }),
                          DropdownButtonFormField<String>(
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Role'),
                            validator: (value) =>
                                value == null ? 'Select a role' : null,
                            onChanged: (value) {
                              setState(() => role = value);
                            },
                            items: ['Mentee']
                                .map<DropdownMenuItem<String>>((String roles) {
                              return DropdownMenuItem<String>(
                                value: roles,
                                child: Text(roles),
                              );
                            }).toList(),
                          ),
                          DropdownButtonFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Mentor'),
                              validator: (value) =>
                                  value == null ? 'Select a mentor' : null,
                              onChanged: (value) {
                                setState(() => mentorName = value);
                              },
                              items: snapshot.data.documents
                                  .map((DocumentSnapshot document) {
                                return new DropdownMenuItem<String>(
                                    value: document.data['displayName'],
                                    child: Text(document.data['displayName']));
                              }).toList()),
                          SizedBox(height: 10.0),
                          RaisedButton(
                              child: Text('Sign Up Mentee'),
                              color: Colors.blue,
                              textColor: Colors.white,
                              elevation: 7.0,
                              onPressed: () async {
                                _formKey.currentState.validate();
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  dynamic result = await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: email, password: password)
                                      .then((signedInUser) async {
                                    FirebaseAuth.instance
                                        .currentUser()
                                        .then((user) {
                                      UserManagement().storeNewMentee(
                                          user,
                                          context,
                                          role,
                                          mentorName,
                                          menteeName,
                                          password,
                                          programme,
                                          intake);
                                      UserManagement().updateMenteeNameList(
                                          mentorName, menteeName);
                                      UserManagement().updateMenteeEmailList(
                                          mentorName, email);
                                      UserManagement().updateMenteeListEmail(
                                          mentorName, email);
                                      // UserManagement().updateMenteeListName(
                                      //     mentorName, menteeName);
                                    }).catchError((e) {
                                      print(e);
                                    });
                                  }).catchError((e) {
                                    print(e);
                                  });
                                  if (result == null) {
                                    setState(() {
                                      error = 'Invalid Credentials';
                                      loading = false;
                                    });
                                  }
                                }
                              }),
                          SizedBox(height: 10.0),
                          RaisedButton(
                            child: Text('Sign Out'),
                            color: Colors.blue,
                            textColor: Colors.white,
                            elevation: 7.0,
                            onPressed: () {
                              FirebaseAuth.instance.signOut().then((val) {
                                Navigator.of(context)
                                    .pushReplacementNamed('/landingpage');
                              }).catchError((e) {
                                print(e);
                              });
                            },
                          ),
                        ],
                      ))),
            );
          } else {
            return new Text('Error');
          }
        },
      ),
    );
  }
}
