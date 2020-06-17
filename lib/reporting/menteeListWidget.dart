import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentor_program/homepage.dart';
import 'package:mentor_program/reporting/filterList.dart';

class MenteeList extends StatefulWidget {
  @override
  _MenteeListState createState() => _MenteeListState();
}

class _MenteeListState extends State<MenteeList> {
  var uid;
  String mentees;
  var menteeList;
  var displayName;
  var email;
  String mentorName;
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
        mentorName = user.displayName;
        email = user.email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => FilterList())),
                  child: Icon(Icons.more_vert),
                )),
          ],
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomePage()))),
          backgroundColor: Colors.blue,
          title: TextField(
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'BalooTamma',
            ),
            decoration: InputDecoration(hintText: 'Search Mentee Name'),
            onChanged: (val) => initiateSearch(val),
          ),
          centerTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: name != "" && name != null
            ? Firestore.instance
                .collection('/student')
                .where('menteeName', isEqualTo: name)
                .snapshots()
            : Firestore.instance
                .collection('/student')
                .where('mentorName', isEqualTo: mentorName)
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot documentSnapshot =
                    snapshot.data.documents[index];
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Name :',
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(fontSize: 25.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        documentSnapshot['menteeName'],
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        'E-mail :',
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(fontSize: 25.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        documentSnapshot['email'],
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        'Programme :',
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(fontSize: 25.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        documentSnapshot['programme'],
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        'Intake :',
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(fontSize: 25.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        documentSnapshot['intake'],
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        'Phone Number:',
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(fontSize: 25.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        documentSnapshot['phoneNumber'],
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        'Year:',
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(fontSize: 25.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        documentSnapshot['year'],
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: 'BalooTamma'),
                      ),
                      SizedBox(height: 1.0),
                      Text(
                        '--------------------',
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: 'BalooTamma'),
                      ),
                    ],
                  ),
                );
              },
            );
        },
      ),
    );
  }
}
