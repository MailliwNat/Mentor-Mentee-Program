import 'package:flutter/material.dart';
import 'package:mentor_program/meetingformpage.dart';
import 'package:mentor_program/mentorAppointmentPage.dart';
import 'profilepage.dart';
import 'dashboardpage.dart';
import 'meetingformpage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
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
          DashboardPage(),
          MeetingFormPage(),
          MentorAppointment(),
          ProfilePage(),
        ],
      ),
    );
  }
}
