import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentor_program/homepage.dart';

class SaveDrafts extends StatefulWidget {
  @override
  _SaveDraftsState createState() => _SaveDraftsState();
}

class _SaveDraftsState extends State<SaveDrafts> {
  TextStyle style = TextStyle(fontFamily: 'BalooTamma', fontSize: 20.0);
  final _formKey = GlobalKey<FormState>();
  String email;
  var recipientEmail;
  String content;
  String topic;
  var displayName;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        email = user.email;
        displayName = user.displayName;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomePage()))),
          centerTitle: true,
          title: Text(
            'Create E-mail Draft',
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: TextFormField(
                          validator: (value) =>
                              (value.isEmpty) ? "Enter Topic" : null,
                          style: style,
                          decoration: InputDecoration(
                              labelText: "Topic",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onChanged: (value) {
                            setState(() {
                              topic = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: TextFormField(
                          minLines: 3,
                          maxLines: 5,
                          validator: (value) =>
                              (value.isEmpty) ? "Enter Content" : null,
                          style: style,
                          decoration: InputDecoration(
                              labelText: "Content",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onChanged: (value) {
                            setState(() {
                              content = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Center(
                        child: RaisedButton(
                            child: Text('Save Draft'),
                            color: Colors.blue,
                            textColor: Colors.white,
                            elevation: 7.0,
                            onPressed: () async {
                              _formKey.currentState.validate();
                              if (_formKey.currentState.validate()) {
                                saveDraft(email, displayName, topic, content);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            HomePage()));
                              }
                            }),
                      ),
                    ],
                  )),
            ),
          ),
        ));
  }

  Future saveDraft(
      String email, String displayName, String topic, String content) async {
    await Firestore.instance.collection('/EmailDrafts').add({
      'email': email,
      'mentorName': displayName,
      'emailTopic': topic,
      'emailContent': content
    });
  }

  // Future saveDraftTopic(String topic) async {
  //   await Firestore.instance
  //       .collection('/staff')
  //       .where('displayName', isEqualTo: displayName)
  //       .getDocuments()
  //       .then((doc) {
  //     Firestore.instance
  //         .document('/staff/${doc.documents[0].documentID}')
  //         .updateData({
  //       'emailTopic': FieldValue.arrayUnion([topic])
  //     }).then((val) {
  //       print('Updated');
  //     }).catchError((e) {
  //       print(e);
  //     });
  //   });
  // }

  // Future saveDraftContent(String content) async {
  //   await Firestore.instance
  //       .collection('/staff')
  //       .where('displayName', isEqualTo: displayName)
  //       .getDocuments()
  //       .then((doc) {
  //     Firestore.instance
  //         .document('/staff/${doc.documents[0].documentID}')
  //         .updateData({
  //       'emailContent': FieldValue.arrayUnion([content])
  //     }).then((val) {
  //       print('Updated');
  //     }).catchError((e) {
  //       print(e);
  //     });
  //   });
  // }
}
