import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentor_program/menteeHomePage.dart';

class MenteeViewInfo extends StatefulWidget {
  @override
  _MenteeViewInfoState createState() => _MenteeViewInfoState();
}

class _MenteeViewInfoState extends State<MenteeViewInfo> {
  String email;

  String displayName;

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
      appBar: new AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => MenteeHomePage()))),
          backgroundColor: Colors.blue,
          title: new Text(
            'Mentor Information',
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'BalooTamma',
            ),
          ),
          centerTitle: true),
      body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('staff')
              .where('menteeEmail', arrayContains: email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshot.data.documents[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          Text('Mentor Name:',
                              style: TextStyle(
                                  fontSize: 25.0, fontFamily: 'BalooTamma')),
                          SizedBox(height: 20.0),
                          Text(
                            documentSnapshot['displayName'].toString(),
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: 'BalooTamma'),
                          ),
                          SizedBox(height: 30.0),
                          Text('Mentor E-mail:',
                              style: TextStyle(
                                  fontSize: 25.0, fontFamily: 'BalooTamma')),
                          SizedBox(height: 20.0),
                          Text(
                            documentSnapshot['email'].toString(),
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: 'BalooTamma'),
                          ),
                          SizedBox(height: 30.0),
                          Text('Education:',
                              style: TextStyle(
                                  fontSize: 25.0, fontFamily: 'BalooTamma')),
                          SizedBox(height: 20.0),
                          Text(
                            documentSnapshot['education'].toString(),
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: 'BalooTamma'),
                          ),
                          SizedBox(height: 30.0),
                          Text('Research Interest:',
                              style: TextStyle(
                                  fontSize: 25.0, fontFamily: 'BalooTamma')),
                          SizedBox(height: 20.0),
                          Text(
                            documentSnapshot['researchInterest'].toString(),
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: 'BalooTamma'),
                          ),
                          SizedBox(height: 30.0),
                          Text('Interest:',
                              style: TextStyle(
                                  fontSize: 25.0, fontFamily: 'BalooTamma')),
                          SizedBox(height: 20.0),
                          Text(
                            documentSnapshot['interest1'].toString(),
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: 'BalooTamma'),
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            documentSnapshot['interest2'].toString(),
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: 'BalooTamma'),
                          ),
                          SizedBox(height: 30.0),
                          Text('Hobby:',
                              style: TextStyle(
                                  fontSize: 25.0, fontFamily: 'BalooTamma')),
                          SizedBox(height: 20.0),
                          Text(
                            documentSnapshot['hobby1'].toString(),
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: 'BalooTamma'),
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            documentSnapshot['hobby2'].toString(),
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: 'BalooTamma'),
                          ),
                        ],
                      ),
                    );
                  });
            }
          }),
    );
  }
}
