import 'package:flutter/material.dart';
import 'package:mentor_program/menteeHomePage.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => MenteeHomePage()))),
          backgroundColor: Colors.blue,
          title: new Text('Sunway Mentoring Program'),
          centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          child: new Padding(
            padding: EdgeInsets.fromLTRB(40, 0, 25, 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Mentoring Program Benefits',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25.0,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'BalooTamma')),
                Column(
                  children: <Widget>[
                    SizedBox(height: 15),
                    Text(
                        '1. Help ease the student\'s transition to university life.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20.0, fontFamily: 'BalooTamma')),
                    SizedBox(height: 15),
                    Text(
                        '2. Help students achieve a sense of engagement and belonging at Sunway.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20.0, fontFamily: 'BalooTamma')),
                    SizedBox(height: 15),
                    Text(
                        '3. Provide students guidance or assistance if needed.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20.0, fontFamily: 'BalooTamma')),
                    SizedBox(height: 15),
                    Text('4. Assist with student\'s character development.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20.0, fontFamily: 'BalooTamma')),
                    SizedBox(height: 15),
                    Text('5. Help with student\'s academic issues. ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20.0, fontFamily: 'BalooTamma')),
                    SizedBox(height: 15),
                    Text(
                        '6. Facilitate decisions regarding course selection and career goals.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20.0, fontFamily: 'BalooTamma')),
                    SizedBox(height: 15),
                    Text(
                        '7. You can get your mentor to write a referral letter for your internship.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20.0, fontFamily: 'BalooTamma')),
                    SizedBox(height: 15),
                    Text(
                        '8. Your mentor will be more willing to act as a referral person in your Cover Letter',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20.0, fontFamily: 'BalooTamma')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
