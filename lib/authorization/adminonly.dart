import 'package:flutter/material.dart';
import 'package:mentor_program/authorization/adminlanding.dart';

class AdminOnly extends StatefulWidget {
  @override
  _AdminOnlyState createState() => _AdminOnlyState();
}

class _AdminOnlyState extends State<AdminOnly>
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
      body: AdminLanding(),
    );
  }
}
