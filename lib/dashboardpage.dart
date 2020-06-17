import 'package:flutter/material.dart';
import 'package:mentor_program/reporting/meetingFormRecords.dart';
import 'package:mentor_program/reporting/menteeListWidget.dart';
import 'package:mentor_program/reporting/reportService.dart';
import 'package:mentor_program/reporting/sendEmailToMentee/showDrafts.dart';

import 'reporting/notifyTimeChange.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blue,
          title: new Text('Mentor Tools'),
          centerTitle: true,
        ),
        body: new Center(
          child: Container(
            padding: EdgeInsets.all(25.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                Text('Please log into your Sunway E-mail on your device',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'BalooTamma')),
                SizedBox(height: 25.0),
                RaisedButton(
                    child: Text('View Mentee List'),
                    color: Colors.blue,
                    textColor: Colors.black,
                    elevation: 7.0,
                    onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => MenteeList()))),
                SizedBox(height: 25.0),
                RaisedButton(
                    child: Text('View Appointments'),
                    color: Colors.green,
                    textColor: Colors.black,
                    elevation: 7.0,
                    onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                AppointmentData()))),
                SizedBox(height: 25.0),
                RaisedButton(
                    child: Text('View Meeting Forms'),
                    color: Colors.red,
                    textColor: Colors.black,
                    elevation: 7.0,
                    onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                MeetingFormRecord()))),
                SizedBox(height: 25.0),
                RaisedButton(
                    child: Text('Notify Appointment Time Change'),
                    color: Colors.purple,
                    textColor: Colors.black,
                    elevation: 7.0,
                    onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ChangeTime()))),
                // SizedBox(height: 25.0),
                // RaisedButton(
                //     child: Text('Send E-mail to mentees'),
                //     color: Colors.orange,
                //     textColor: Colors.black,
                //     elevation: 7.0,
                //     onPressed: () => Navigator.pushReplacement(
                //         context,
                //         MaterialPageRoute(
                //             builder: (BuildContext context) => ShowDrafts()))),
              ],
            ),
          ),
        ));
  }
}
