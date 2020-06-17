import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentor_program/homepage.dart';
import 'package:mentor_program/shared/constants.dart';

class AppointmentData extends StatefulWidget {
  @override
  _AppointmentDataState createState() => _AppointmentDataState();
}

class _AppointmentDataState extends State<AppointmentData> {
  TextEditingController editingController = TextEditingController();
  var uid;
  var mentorName;
  var email;
  var menteeName;
  String displayName;
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
    return Scaffold(
      appBar: new AppBar(
          title: TextField(
            decoration: InputDecoration(hintText: 'Search Mentee Name'),
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'BalooTamma',
            ),
            onChanged: (val) => initiateSearch(val),
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomePage()))),
          backgroundColor: Colors.blue,
          centerTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: name != "" && name != null
            ? Firestore.instance
                .collection('/appointments')
                .where('menteeName', isEqualTo: name)
                .snapshots()
            : Firestore.instance
                .collection('/appointments')
                .where('mentorName', isEqualTo: displayName)
                .orderBy('date&time', descending: true)
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return new ListView.builder(
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
                        SizedBox(height: 20.0),
                        Text('Mentee Name',
                            style: TextStyle(
                                fontSize: 25.0, fontFamily: 'BalooTamma')),
                        SizedBox(height: 20.0),
                        Text(
                          documentSnapshot['menteeName'].toString(),
                          style: TextStyle(
                              fontSize: 20.0, fontFamily: 'BalooTamma'),
                        ),
                        SizedBox(height: 15.0),
                        Text('Date & Time',
                            style: TextStyle(
                                fontSize: 25.0, fontFamily: 'BalooTamma')),
                        SizedBox(height: 20.0),
                        Text(
                          formattedDateTime,
                          style: TextStyle(
                              fontSize: 20.0, fontFamily: 'BalooTamma'),
                        ),
                        SizedBox(height: 20.0),
                        Text('Appointment Topic',
                            style: TextStyle(
                                fontSize: 25.0, fontFamily: 'BalooTamma')),
                        SizedBox(height: 20.0),
                        Text(
                          documentSnapshot['appointment_topic'],
                          style: TextStyle(
                              fontSize: 20.0, fontFamily: 'BalooTamma'),
                        ),
                        SizedBox(height: 20.0),
                        Text('Short Description',
                            style: TextStyle(
                                fontSize: 25.0, fontFamily: 'BalooTamma')),
                        SizedBox(height: 20.0),
                        Text(
                          documentSnapshot['description'].toString(),
                          style: TextStyle(
                              fontSize: 20.0, fontFamily: 'BalooTamma'),
                        ),
                        // SizedBox(height: 20.0),
                        // Text('Mentor Name',
                        //     style: TextStyle(
                        //         fontSize: 25.0, fontFamily: 'BalooTamma')),
                        // SizedBox(height: 20.0),
                        // Text(
                        //   documentSnapshot['mentorName'].toString(),
                        //   style: TextStyle(
                        //       fontSize: 20.0, fontFamily: 'BalooTamma'),
                        // ),

                        SizedBox(height: 20.0),
                        Text(
                          '--------------------',
                          style: TextStyle(
                              fontSize: 20.0, fontFamily: 'BalooTamma'),
                        ),
                      ],
                    ),
                  );
                });
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
                      Text('Date & Time',
                          style: TextStyle(
                              fontSize: 25.0, fontFamily: 'BalooTamma')),
                      SizedBox(height: 20.0),
                      Text(
                        formattedDateTime,
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 20.0),
                      Text('Appointment Topic',
                          style: TextStyle(
                              fontSize: 25.0, fontFamily: 'BalooTamma')),
                      SizedBox(height: 20.0),
                      Text(
                        documentSnapshot['appointment_topic'],
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 20.0),
                      Text('Short Description',
                          style: TextStyle(
                              fontSize: 25.0, fontFamily: 'BalooTamma')),
                      SizedBox(height: 20.0),
                      Text(
                        documentSnapshot['description'].toString(),
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 20.0),
                      Text('Mentor Name',
                          style: TextStyle(
                              fontSize: 25.0, fontFamily: 'BalooTamma')),
                      SizedBox(height: 20.0),
                      Text(
                        documentSnapshot['mentorName'].toString(),
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 20.0),
                      Text('Mentee Name',
                          style: TextStyle(
                              fontSize: 25.0, fontFamily: 'BalooTamma')),
                      SizedBox(height: 20.0),
                      Text(
                        documentSnapshot['menteeName'].toString(),
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        '--------------------',
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: 'BalooTamma'),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Text(
              'Loading...',
              style: TextStyle(fontSize: 30.0, fontFamily: 'BalooTamma'),
            );
          }
        },
      ),
    );
  }
}
