import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:mentor_program/homepage.dart';
import 'package:mentor_program/shared/constants.dart';
import 'event_firestore.dart';
import 'event.dart';
import 'package:mentor_program/formsubmission/meetingForm.dart';

class MentorAppointmentPage extends StatefulWidget {
  final EventModel note;

  const MentorAppointmentPage({Key key, this.note}) : super(key: key);

  @override
  _MentorAppointmentPageState createState() => _MentorAppointmentPageState();
}

class _MentorAppointmentPageState extends State<MentorAppointmentPage> {
  TextStyle style = TextStyle(fontFamily: 'BalooTamma', fontSize: 20.0);
  TextEditingController _title;
  TextEditingController _description;
  String title;
  String description;
  String menteeName;
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy HH:mm');
  DateTime selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  DatabaseService storeNewAppointment = new DatabaseService();
  bool processing;
  var mentorName;
  var useremail;
  var email;
  var mentorEmail;
  var recipientEmail;
  var password;
  var menteeEmail;
  String displayName;

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
        mentorName = user.displayName;
      });
    });
    _title = TextEditingController(
        text: widget.note != null ? widget.note.title : "");
    _description = TextEditingController(
        text: widget.note != null ? widget.note.description : "");
    processing = false;
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
        title: Text(widget.note != null ? "Edit Event" : "Add Appointment"),
        centerTitle: true,
      ),
      key: _key,
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(15),
          child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('/student')
                  .where('mentorName', isEqualTo: mentorName)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: DropdownButtonFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Mentee Email'),
                            validator: (value) =>
                                value == null ? 'Select email' : null,
                            onChanged: (value) {
                              setState(() => menteeEmail = value);
                            },
                            items: snapshot.data.documents
                                .map((DocumentSnapshot document) {
                              return new DropdownMenuItem<dynamic>(
                                  value: document.data['email'],
                                  child:
                                      Text(document.data['email'].toString()));
                            }).toList()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: TextFormField(
                          controller: _title,
                          validator: (value) => (value.isEmpty)
                              ? "Enter topic to be discussed"
                              : null,
                          style: style,
                          decoration: InputDecoration(
                              labelText: "Topic to be discussed",
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
                          controller: _description,
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
                                                      FirebaseAuth.instance
                                                          .currentUser()
                                                          .then((user) {
                                                        setState(() {
                                                          mentorName =
                                                              user.displayName;
                                                        });
                                                      }).then((value) {
                                                        DatabaseService()
                                                            .storeNewAppointment(
                                                          title,
                                                          description,
                                                          menteeName,
                                                          selectedDate,
                                                          mentorName,
                                                          recipientEmail,
                                                          menteeEmail,
                                                        )
                                                            .then((value) {
                                                          customLaunch(
                                                              'mailto:$menteeEmail?subject=New Appointment ($title)&body=Your mentor, $mentorName, would like to make an appointment with you on ${dateFormat.format(selectedDate)}.\nAppointment Title: $title\nAppointment description: $description\nPlease reply.');

                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      HomePage()));
                                                        });
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
              }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }
}
