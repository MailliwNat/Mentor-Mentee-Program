import 'package:flutter/material.dart';
import 'package:mentor_program/formsubmission/menteeMeetingForm.dart';
import 'package:mentor_program/meetingformpage.dart';
import 'package:mentor_program/menteeDashboard.dart';
import 'package:mentor_program/menteeProfile.dart';
import 'appointmentpage.dart';
import 'meetingformpage.dart';

class MenteeHomePage extends StatefulWidget {
  @override
  _MenteeHomePageState createState() => _MenteeHomePageState();
}

class _MenteeHomePageState extends State<MenteeHomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Material(
        color: Colors.blue[700],
        child: TabBar(
          controller: tabController,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.assignment)),
            Tab(icon: Icon(Icons.calendar_today)),
            Tab(icon: Icon(Icons.person)),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          MenteeDashboard(),
          MenteeMeetingForm(),
          AppointmentPage(),
          MenteeProfilePage(),
        ],
      ),
    );
  }
}
