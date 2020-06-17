import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentor_program/infoPage.dart';

class MenteeDashboard extends StatefulWidget {
  @override
  _MenteeDashboardState createState() => _MenteeDashboardState();
}

class _MenteeDashboardState extends State<MenteeDashboard> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blue,
        title: new Text('Mentoring Program'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((val) {
                  Navigator.of(context).pushReplacementNamed('/landingpage');
                });
              })
        ],
      ),
      body: Center(
        child: new Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30),
                Text('How is this programme beneficial to you?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'BalooTamma')),
                SizedBox(height: 30),
                RaisedButton.icon(
                    onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => InfoPage())),
                    icon: Icon(Icons.info_outline),
                    label: Text(
                      'Tap to find out more!',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'BalooTamma'),
                    )),
                Container(
                    padding: EdgeInsets.all(40), child: SizedBox(height: 20)),
                Text('Note: Login to your Sunway E-mail on your device',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'BalooTamma')),
              ]),
        ),
      ),
    );
  }
}
