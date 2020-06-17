import 'package:flutter/material.dart';
import 'package:mentor_program/menteeSignUp.dart';
import 'package:mentor_program/signuppage.dart';

class AdminLanding extends StatefulWidget {
  @override
  _AdminLandingState createState() => _AdminLandingState();
}

class _AdminLandingState extends State<AdminLanding>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: Material(
        color: Colors.blue[700],
        child: TabBar(
          controller: tabController,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.person_add)),
            Tab(icon: Icon(Icons.person)),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          MenteeSignUp(),
          MentorSignUp(),
        ],
      ),
    );
  }
}
