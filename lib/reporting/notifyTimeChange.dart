import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentor_program/formsubmission/meetingForm.dart';
import 'package:mentor_program/homepage.dart';
import 'package:mentor_program/shared/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ChangeTime extends StatefulWidget {
  @override
  _ChangeTimeState createState() => _ChangeTimeState();
}

class _ChangeTimeState extends State<ChangeTime> {
  TextStyle style = TextStyle(fontFamily: 'BalooTamma', fontSize: 20.0);
  final _formKey = GlobalKey<FormState>();
  var displayName;
  var menteeName;
  var recipientEmail;
  String description;
  String title;
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy HH:mm');
  DateTime selectedDate = DateTime.now();

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
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
                    builder: (BuildContext context) => HomePage()))),
        title: Text('Notify Changes'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(15.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('/student')
                .where('mentorName', isEqualTo: displayName)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: DropdownButtonFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Mentee Name'),
                          validator: (value) =>
                              value == null ? 'Select a mentee' : null,
                          onChanged: (value) {
                            setState(() => menteeName = value);
                          },
                          items: snapshot.data.documents
                              .map((DocumentSnapshot document) {
                            return new DropdownMenuItem<dynamic>(
                                value: document.data['menteeName'],
                                child: Text(
                                    document.data['menteeName'].toString()));
                          }).toList()),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: DropdownButtonFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Mentee Email'),
                          validator: (value) =>
                              value == null ? 'Select email' : null,
                          onChanged: (value) {
                            setState(() => recipientEmail = value);
                          },
                          items: snapshot.data.documents
                              .map((DocumentSnapshot document) {
                            return new DropdownMenuItem<dynamic>(
                                value: document.data['email'],
                                child: Text(document.data['email'].toString()));
                          }).toList()),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: TextFormField(
                        validator: (value) =>
                            (value.isEmpty) ? "Enter title" : null,
                        style: style,
                        decoration: InputDecoration(
                            labelText: "Title",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onChanged: (value) {
                          setState(
                            () => title = value,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: TextFormField(
                        minLines: 3,
                        maxLines: 5,
                        validator: (value) => (value.isEmpty)
                            ? "Please enter a brief description"
                            : null,
                        style: style,
                        decoration: InputDecoration(
                            labelText: "Brief description",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onChanged: (value) {
                          setState(
                            () => description = value,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10.0),
                    ListTile(
                      title: Text("Date & Time (DD-MM-YYYY-HH-MM)"),
                      subtitle: Text(dateFormat.format(selectedDate)),
                      onTap: () async {
                        showDateTimeDialog(context, initialDate: selectedDate,
                            onSelectedDate: (selectedDate) {
                          setState(() {
                            this.selectedDate = selectedDate;
                          });
                        });
                      },
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Theme.of(context).primaryColor,
                        child: MaterialButton(
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Stack(
                                      overflow: Overflow.visible,
                                      children: <Widget>[
                                        Positioned(
                                          right: -40.0,
                                          top: -40.0,
                                          child: InkResponse(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: CircleAvatar(
                                              child: Icon(Icons.close),
                                              backgroundColor: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  15, 15, 15, 15),
                                              child: Text(
                                                'Details Confirmed? ',
                                                style: TextStyle(
                                                    fontSize: 25.0,
                                                    fontFamily: 'BalooTamma'),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(30.0),
                                              child: RaisedButton(
                                                child: Text(
                                                  "Send Email to inform",
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontFamily: 'BalooTamma',
                                                  ),
                                                ),
                                                color: Colors.blue,
                                                textColor: Colors.white,
                                                elevation: 7.0,
                                                onPressed: () {
                                                  _formKey.currentState
                                                      .validate();
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    customLaunch(
                                                        'mailto:$recipientEmail?subject=New Appointment ($title)&body=Your mentor, $displayName, would like to inform you about: \nTitle: $title \nDescription: $description\nTime: ${dateFormat.format(selectedDate)}');

                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                HomePage()));
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Text(
                            "Tap to proceed",
                            style: style.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return new Text(
                  'Error',
                  style: TextStyle(fontSize: 25.0, fontFamily: 'BalooTamma'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
