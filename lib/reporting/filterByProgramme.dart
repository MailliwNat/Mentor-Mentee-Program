import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentor_program/reporting/filterList.dart';
import 'package:mentor_program/shared/constants.dart';

class ProgrammeFilter extends StatefulWidget {
  @override
  _ProgrammeFilterState createState() => _ProgrammeFilterState();
}

class _ProgrammeFilterState extends State<ProgrammeFilter> {
  String programme = "";
  String displayName;

  void initiateSearch(String value) {
    setState(() {
      programme = value;
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
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
                    builder: (BuildContext context) => FilterList()))),
        backgroundColor: Colors.blue,
        title: Container(
          color: Colors.blue,
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            style: TextStyle(
              fontSize: 17.0,
              fontFamily: 'BalooTamma',
            ),
            decoration: InputDecoration(
                hintText: 'Search by Programme',
                filled: true,
                fillColor: Color(7)),
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
                  style: TextStyle(color: Colors.black),
                  overflow: TextOverflow.visible,
                ),
              );
            }).toList(),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: programme != "" && programme != null
                          ? Firestore.instance
                              .collection('/student')
                              .where('programme', isEqualTo: programme)
                              .where('mentorName', isEqualTo: displayName)
                              .snapshots()
                          : Firestore.instance
                              .collection('/student')
                              .where('mentorName', isEqualTo: displayName)
                              .snapshots(),
                      builder: (context, snapshot) {
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
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          fontFamily: 'BalooTamma'),
                                    ),
                                    SizedBox(height: 15.0),
                                    Text(
                                      documentSnapshot['menteeName'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: 'BalooTamma'),
                                    ),
                                    SizedBox(height: 15.0),
                                    Text(
                                      'E-mail :',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          fontFamily: 'BalooTamma'),
                                    ),
                                    SizedBox(height: 15.0),
                                    Text(
                                      documentSnapshot['email'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: 'BalooTamma'),
                                    ),
                                    SizedBox(height: 15.0),
                                    Text(
                                      'Programme :',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          fontFamily: 'BalooTamma'),
                                    ),
                                    SizedBox(height: 15.0),
                                    Text(
                                      documentSnapshot['programme'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: 'BalooTamma'),
                                    ),
                                    SizedBox(height: 15.0),
                                    Text(
                                      'Intake :',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          fontFamily: 'BalooTamma'),
                                    ),
                                    SizedBox(height: 15.0),
                                    Text(
                                      documentSnapshot['intake'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: 'BalooTamma'),
                                    ),
                                    SizedBox(height: 15.0),
                                    Text(
                                      'Phone Number:',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          fontFamily: 'BalooTamma'),
                                    ),
                                    SizedBox(height: 15.0),
                                    Text(
                                      documentSnapshot['phoneNumber'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: 'BalooTamma'),
                                    ),
                                    SizedBox(height: 15.0),
                                    Text(
                                      'Year:',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          fontFamily: 'BalooTamma'),
                                    ),
                                    SizedBox(height: 15.0),
                                    Text(
                                      documentSnapshot['year'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: 'BalooTamma'),
                                    ),
                                    SizedBox(height: 15.0),
                                    Text(
                                      '--------------------',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: 'BalooTamma'),
                                    ),
                                  ],
                                ),
                              );
                            });
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
