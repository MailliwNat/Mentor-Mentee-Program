import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentor_program/formsubmission/form_submission.dart';
import 'package:mentor_program/homepage.dart';
import 'package:mentor_program/shared/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'meetingForm.dart';

class MeetingFormDetailsPage extends StatefulWidget {
  @override
  _MeetingFormDetailsPageState createState() => _MeetingFormDetailsPageState();
}

class _MeetingFormDetailsPageState extends State<MeetingFormDetailsPage> {
  String menteeName;
  String mentorName;
  var itemDiscussed;
  DateTime selectedDate = DateTime.now();
  DatabaseService formSubmission = new DatabaseService();
  final _formKey = GlobalKey<FormState>();
  TextStyle style = TextStyle(fontFamily: 'BalooTamma', fontSize: 20.0);
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mma');
  String programme;
  String intake;
  String currentSemester;
  String displayName;
  var recipientEmail;
  bool agreement = false;

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('could not launch $command');
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
          backgroundColor: Colors.blue,
          title: Text('Meeting Record Form'),
          centerTitle: true),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 2, 20, 0),
          child: Form(
            key: _formKey,
            child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection('/student')
                    .where('mentorName', isEqualTo: displayName)
                    .snapshots(),
                builder: (context, snapshot) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 3.0),
                      ListTile(
                        title: Text('Session time', style: style),
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
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: DropdownButtonFormField(
                            isExpanded: true,
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Mentee E-mail'),
                            validator: (value) =>
                                value == null ? 'Select mentee E-mail' : null,
                            onChanged: (value) {
                              setState(() => recipientEmail = value);
                            },
                            items: snapshot.data.documents
                                .map((DocumentSnapshot document) {
                              return new DropdownMenuItem<String>(
                                  value: document.data['email'],
                                  child: Text(
                                    document.data['email'],
                                    overflow: TextOverflow.clip,
                                  ));
                            }).toList()),
                      ),
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: DropdownButtonFormField(
                            isExpanded: true,
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Mentee Name'),
                            validator: (value) =>
                                value == null ? 'Select a Mentee' : null,
                            onChanged: (value) {
                              setState(() => menteeName = value);
                            },
                            items: snapshot.data.documents
                                .map((DocumentSnapshot document) {
                              return new DropdownMenuItem<String>(
                                  value: document.data['menteeName'],
                                  child: Text(
                                    document.data['menteeName'],
                                    overflow: TextOverflow.clip,
                                  ));
                            }).toList()),
                      ),
                      // SizedBox(height: 3.0),
                      // TextFormField(
                      //   validator: (value) =>
                      //       value.isEmpty ? 'Mentor\s name' : null,
                      //   style: style,
                      //   decoration: InputDecoration(
                      //     labelText: 'Mentor\s name',
                      //     filled: true,
                      //     fillColor: Colors.white,
                      //   ),
                      //   onChanged: (value) {
                      //     setState(() => mentorName = value);
                      //   },
                      // ),
                      // SizedBox(height: 3.0),
                      // TextFormField(
                      //   validator: (value) =>
                      //       value.isEmpty ? 'Enter mentee\'s name' : null,
                      //   style: style,
                      //   decoration: InputDecoration(
                      //     labelText: 'Attending Mentees',
                      //     filled: true,
                      //     fillColor: Colors.white,
                      //   ),
                      //   onChanged: (value) {
                      //     setState(() => menteeName = value);
                      //   },
                      // ),
                      Padding(
                          padding: EdgeInsets.all(0),
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Enrolled Programme'),
                            validator: (value) =>
                                value == null ? 'Select a Programme' : null,
                            onChanged: (value) {
                              setState(() => programme = value);
                            },
                            items: [
                              'BSc (Hons) in Computer Science',
                              'BSc (Hons) Information Technology',
                              'BSc (Hons) Information Technology (Computer Networking and Security)',
                              'BSc (Hons) Information Systems',
                              'BSc (Hons) Information Systems (Business Analytics)',
                              'Bachelor of Software Engineering (Hons)'
                            ].map<DropdownMenuItem<String>>((String programme) {
                              return DropdownMenuItem<String>(
                                value: programme,
                                child: Text(
                                  programme,
                                  overflow: TextOverflow.clip,
                                ),
                              );
                            }).toList(),
                          )),
                      SizedBox(height: 3.0),
                      TextFormField(
                        validator: (value) =>
                            value.isEmpty ? 'Enter Intake' : null,
                        style: style,
                        decoration: InputDecoration(
                          labelText: 'Intake',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onChanged: (value) {
                          setState(() => intake = value);
                        },
                      ),
                      SizedBox(height: 3.0),
                      TextFormField(
                        validator: (value) =>
                            value.isEmpty ? 'Enter current semester' : null,
                        style: style,
                        decoration: InputDecoration(
                          labelText: 'Current semester',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onChanged: (value) {
                          setState(() => currentSemester = value);
                        },
                      ),
                      SizedBox(height: 3.0),
                      TextFormField(
                        minLines: 1,
                        maxLines: 3,
                        style: style,
                        decoration: InputDecoration(
                          labelText: "Items discussed",
                        ),
                        onChanged: (value) {
                          setState(() => itemDiscussed = value);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          'Confirmation',
                          style: TextStyle(fontSize: 15),
                        ),
                        value: agreement,
                        onChanged: (newValue) {
                          if (agreement == false) {
                            setState(() {
                              agreement = newValue;
                              agreement = true;
                            });
                          } else if (agreement == true) {
                            setState(() {
                              agreement = false;
                            });
                          }
                        },
                        subtitle: !agreement
                            ? Text(
                                'Selecting the checkbox means both party has confirmed the details above.',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 15),
                              )
                            : null,
                      ),
                      Text(
                        'Note: No admendments will be made after form submission.',
                        style:
                            TextStyle(fontSize: 15.0, fontFamily: 'BalooTamma'),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20.0),
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
                                                    const EdgeInsets.all(20.0),
                                                child: RaisedButton(
                                                  child: Text(
                                                    "Tap to Submit Form",
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
                                                      DatabaseService()
                                                          .storeNewForm(
                                                              displayName,
                                                              menteeName,
                                                              itemDiscussed,
                                                              selectedDate,
                                                              programme,
                                                              intake,
                                                              currentSemester,
                                                              recipientEmail,
                                                              agreement)
                                                          .then((value) {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    HomePage()));
                                                      });
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
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
