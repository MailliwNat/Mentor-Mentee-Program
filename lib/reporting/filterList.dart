import 'package:flutter/material.dart';
import 'package:mentor_program/reporting/filterByIntake.dart';
import 'package:mentor_program/reporting/filterByProgramme.dart';
import 'package:mentor_program/reporting/filterByYear.dart';
import 'package:mentor_program/reporting/menteeListWidget.dart';

class FilterList extends StatefulWidget {
  @override
  _FilterListState createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => MenteeList()))),
        backgroundColor: Colors.blue,
        title: Text(
          'Select Filtering Method',
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'BalooTamma',
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 50.0,
                width: 100.0,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.purpleAccent,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ProgrammeFilter()));
                    },
                    child: Center(
                      child: Text(
                        'Filter By Programme',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'BalooTamma',
                        ),
                      ),
                    ),
                  ),
                )),
            SizedBox(height: 20),
            Container(
                height: 50.0,
                width: 100.0,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.green,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  IntakeFilter()));
                    },
                    child: Center(
                      child: Text(
                        'Filter By Intake',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'BalooTamma',
                        ),
                      ),
                    ),
                  ),
                )),
            SizedBox(height: 20),
            Container(
                height: 50.0,
                width: 100.0,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.indigo,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => YearFilter()));
                    },
                    child: Center(
                      child: Text(
                        'Filter By Year',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'BalooTamma',
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
