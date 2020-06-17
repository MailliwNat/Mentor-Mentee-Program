import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MenteeMeetingForm extends StatefulWidget {
  @override
  _MenteeMeetingFormState createState() => _MenteeMeetingFormState();
}

class _MenteeMeetingFormState extends State<MenteeMeetingForm> {
  var uid;
  var mentorName;
  var email;
  var menteeName;
  var displayName;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        email = user.email;
        menteeName = user.displayName;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.blue,
          title: Text('Meeting Form Record'),
          centerTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('/meetingforms')
            .where('menteeName', isEqualTo: menteeName)
            .orderBy('date&time', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text('Loading...');
          }
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
          else {
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
