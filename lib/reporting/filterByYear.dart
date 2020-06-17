import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentor_program/reporting/filterList.dart';

class YearFilter extends StatefulWidget {
  @override
  _YearFilterState createState() => _YearFilterState();
}

class _YearFilterState extends State<YearFilter> {
  String year = "";
  String displayName;
  String email;

  void initiateSearch(String val) {
    setState(() {
      year = val;
    });
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

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
                      builder: (BuildContext context) => FilterList()))),
          backgroundColor: Colors.blue,
          title: TextField(
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'BalooTamma',
            ),
            decoration: InputDecoration(hintText: 'Search by Year'),
            onChanged: (val) => initiateSearch(val),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: year != "" && year != null
              ? Firestore.instance
                  .collection('/student')
                  .where('year', isEqualTo: year)
                  .where('mentorName', isEqualTo: displayName)
                  .snapshots()
              : Firestore.instance
                  .collection('/student')
                  .where('mentorName', isEqualTo: displayName)
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
                            style: TextStyle(
                                fontSize: 25.0, fontFamily: 'BalooTamma'),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            documentSnapshot['menteeName'],
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: 'BalooTamma'),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            'E-mail :',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 25.0, fontFamily: 'BalooTamma'),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            documentSnapshot['email'],
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: 'BalooTamma'),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            'Programme :',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 25.0, fontFamily: 'BalooTamma'),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            documentSnapshot['programme'],
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: 'BalooTamma'),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            'Intake :',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 25.0, fontFamily: 'BalooTamma'),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            documentSnapshot['intake'],
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: 'BalooTamma'),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            'Phone Number:',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 25.0, fontFamily: 'BalooTamma'),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            documentSnapshot['phoneNumber'],
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: 'BalooTamma'),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            'Year:',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 25.0, fontFamily: 'BalooTamma'),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            documentSnapshot['year'],
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: 'BalooTamma'),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            '--------------------',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: 'BalooTamma'),
                          ),
                        ],
                      ),
                    );
                  });
          },
        ));
  }
}
