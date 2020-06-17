import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentor_program/homepage.dart';

//Meeting Forms let mentor write as it queries with UID, also mentee's meeting form has been replaced with view meeting form record

class MeetingFormRecord extends StatefulWidget {
  @override
  _MeetingFormRecordState createState() => _MeetingFormRecordState();
}

class _MeetingFormRecordState extends State<MeetingFormRecord> {
  var uid;
  var mentorName;
  var email;
  var menteeName;
  var displayName;

  String name = "";

  void initiateSearch(String val) {
    setState(() {
      name = val;
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        uid = user.uid;
        email = user.email;
        menteeName = menteeName;
        displayName = user.displayName;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomePage()))),
          backgroundColor: Colors.blue,
          title: new TextField(
            decoration: InputDecoration(hintText: 'Search Mentee Name'),
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'BalooTamma',
            ),
            onChanged: (val) => initiateSearch(val),
          ),
          centerTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: name != "" && name != null
            ? Firestore.instance
                .collection('/meetingforms')
                .where('menteeName', isEqualTo: name)
                .snapshots()
            : Firestore.instance
                .collection('/meetingforms')
                .where('uid', isEqualTo: uid)
                // .where('mentorName', isEqualTo: displayName)
                .orderBy("date&time", descending: true)
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot documentSnapshot =
                    snapshot.data.documents[index];
                DateTime myDateTime = DateTime.parse(
                    documentSnapshot['date&time'].toDate().toString());
                String formattedDateTime =
                    DateFormat('EEE, d/M/y (hh:mma)').format(myDateTime);
                return Padding(
                  padding: const EdgeInsets.fromLTRB(25, 5, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 15.0),
                      Text('Date & Time:',
                          style: TextStyle(
                              fontSize: 25.0, fontFamily: 'BalooTamma')),
                      SizedBox(height: 20.0),
                      Text(
                        formattedDateTime,
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 30.0),
                      Text('Mentor Name:',
                          style: TextStyle(
                              fontSize: 25.0, fontFamily: 'BalooTamma')),
                      SizedBox(height: 20.0),
                      Text(
                        documentSnapshot['mentorName'].toString(),
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 30.0),
                      Text('Mentee Name:',
                          style: TextStyle(
                              fontSize: 25.0, fontFamily: 'BalooTamma')),
                      SizedBox(height: 20.0),
                      Text(
                        documentSnapshot['menteeName'].toString(),
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 30.0),
                      Text('Intake:',
                          style: TextStyle(
                              fontSize: 25.0, fontFamily: 'BalooTamma')),
                      SizedBox(height: 20.0),
                      Text(
                        documentSnapshot['intake'].toString(),
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 30.0),
                      Text('Current Semester:',
                          style: TextStyle(
                              fontSize: 25.0, fontFamily: 'BalooTamma')),
                      SizedBox(height: 20.0),
                      Text(
                        documentSnapshot['currentSemester'].toString(),
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 30.0),
                      Text('Items Discussed:',
                          style: TextStyle(
                              fontSize: 25.0, fontFamily: 'BalooTamma')),
                      SizedBox(height: 20.0),
                      Text(
                        documentSnapshot['item_discussed'].toString(),
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 30.0),
                      Text('Agreement:',
                          style: TextStyle(
                              fontSize: 25.0, fontFamily: 'BalooTamma')),
                      SizedBox(height: 20.0),
                      Text(
                        documentSnapshot['agreement'].toString(),
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 10),
                      Text('--------------------')
                    ],
                  ),
                );
              },
            );
          if (!snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot documentSnapshot =
                    snapshot.data.documents[index];
                DateTime myDateTime = DateTime.parse(
                    documentSnapshot['date&time'].toDate().toString());
                String formattedDateTime =
                    DateFormat('EEE, d/M/y (hh:mma)').format(myDateTime);
                return Padding(
                  padding: const EdgeInsets.fromLTRB(25, 5, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 15.0),
                      Text('Date & Time:',
                          style: TextStyle(
                              fontSize: 25.0, fontFamily: 'BalooTamma')),
                      SizedBox(height: 20.0),
                      Text(
                        formattedDateTime,
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 30.0),
                      Text('Mentor Name:',
                          style: TextStyle(
                              fontSize: 25.0, fontFamily: 'BalooTamma')),
                      SizedBox(height: 20.0),
                      Text(
                        documentSnapshot['mentorName'].toString(),
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 30.0),
                      Text('Mentee Name:',
                          style: TextStyle(
                              fontSize: 25.0, fontFamily: 'BalooTamma')),
                      SizedBox(height: 20.0),
                      Text(
                        documentSnapshot['menteeName'].toString(),
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 30.0),
                      Text('Intake:',
                          style: TextStyle(
                              fontSize: 25.0, fontFamily: 'BalooTamma')),
                      SizedBox(height: 20.0),
                      Text(
                        documentSnapshot['intake'].toString(),
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 30.0),
                      Text('Current Semester:',
                          style: TextStyle(
                              fontSize: 25.0, fontFamily: 'BalooTamma')),
                      SizedBox(height: 20.0),
                      Text(
                        documentSnapshot['currentSemester'].toString(),
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 30.0),
                      Text('Items Discussed:',
                          style: TextStyle(
                              fontSize: 25.0, fontFamily: 'BalooTamma')),
                      SizedBox(height: 20.0),
                      Text(
                        documentSnapshot['item_discussed'].toString(),
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 10),
                      Text('--------------------')
                    ],
                  ),
                );
              },
            );
          } else {
            return new Text(
              'Loading...',
              style: TextStyle(fontSize: 30.0, fontFamily: 'BalooTamma'),
            );
          }
        },
      ),
    );
  }
}
