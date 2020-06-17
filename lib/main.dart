import 'package:flutter/material.dart';
import 'package:mentor_program/appointment/add_appointment.dart';
import 'package:mentor_program/appointment/appointment.dart';
import 'package:mentor_program/appointment/mentorAppointment.dart';
import 'package:mentor_program/authorization/adminlanding.dart';
import 'package:mentor_program/authorization/adminonly.dart';
import 'package:mentor_program/formsubmission/post_formsubmission.dart';
import 'package:mentor_program/menteeHomePage.dart';
import 'package:mentor_program/reporting/menteeListWidget.dart';
import 'package:mentor_program/reporting/reportService.dart';
import 'package:mentor_program/selectprofilepage.dart';
import 'homepage.dart';
import 'loginpage.dart';
import 'signuppage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: <String, WidgetBuilder>{
        '/landingpage': (BuildContext context) => new MyApp(),
        '/signup': (BuildContext context) => new MentorSignUp(),
        '/homepage': (BuildContext context) => new HomePage(),
        '/loginpage': (BuildContext context) => new LoginPage(),
        '/selectpic': (BuildContext context) => new SelectProfilePage(),
        '/add_appointment': (BuildContext context) => new AddAppointmentPage(),
        '/mentor_add_appointment': (BuildContext context) =>
            new MentorAppointmentPage(),
        'appointment': (BuildContext context) => new Appointment(),
        '/post_submissionpage': (BuildContext context) =>
            new PostSubmissionPage(),
        '/adminonly': (BuildContext context) => new AdminOnly(),
        '/menteehomepage': (BuildContext context) => new MenteeHomePage(),
        '/adminlandingpage': (BuildContext context) => new AdminLanding(),
        '/reportbuttonpage': (BuildContext context) => new MenteeList(),
        '/apointmentformreport': (BuildContext context) =>
            new AppointmentData(),
      },
    );
  }
}
