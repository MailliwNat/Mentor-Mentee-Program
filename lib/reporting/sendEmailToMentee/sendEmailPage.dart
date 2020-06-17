// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mentor_program/homepage.dart';
// import 'package:mentor_program/reporting/sendEmailToMentee/showDrafts.dart';
// import 'package:mentor_program/shared/constants.dart';
// import 'package:url_launcher/url_launcher.dart';

// class SendEmailPage extends StatefulWidget {
//   @override
//   _SendEmailPageState createState() => _SendEmailPageState();
// }

// class _SendEmailPageState extends State<SendEmailPage> {
//   final _formKey = GlobalKey<FormState>();
//   var displayName;
//   var recipientEmail;
//   String email;
//   String uid;

//   @override
//   void initState() {
//     super.initState();
//     FirebaseAuth.instance.currentUser().then((user) {
//       setState(() {
//         email = user.email;
//         displayName = user.displayName;
//         uid = user.uid;
//       });
//     });
//   }

//   Stream<DataList> getList() {
//     return Firestore.instance
//         .collection('EmailDrafts')
//         .document(uid)
//         .get()
//         .then((snapshot) {
//       try {
//         return DataList.fromSnapshot(snapshot);
//       } catch (e) {
//         print(e);
//         return null;
//       }
//     }).asStream();
//   }

//   void customLaunch(command) async {
//     if (await canLaunch(command)) {
//       await launch(command);
//     } else {
//       print('could not launch $command');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () => Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                     builder: (BuildContext context) => ShowDrafts()))),
//         centerTitle: true,
//         title: Text(
//           'Send E-mail',
//         ),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Container(
//           alignment: Alignment.center,
//           padding: EdgeInsets.all(15.0),
//           child: StreamBuilder(
//               stream: getList(),
//               builder: (context, AsyncSnapshot<DataList> data) {
//                 if (data.hasData) {
//                   return Container(
//                     child: Padding(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                       child: Column(
//                         children: <Widget>[
//                           DropdownButtonFormField(
//                               isExpanded: true,
//                               decoration: textInputDecoration.copyWith(
//                                   hintText: 'Mentee\'s E-mail'),
//                               validator: (value) =>
//                                   value == null ? 'Filed Required' : null,
//                               onChanged: (value) {
//                                 setState(() => recipientEmail = value);
//                               },
//                               items: data.documents
//                                   .map((DocumentSnapshot document) {
//                                 return new DropdownMenuItem<dynamic>(
//                                     value:
//                                         document.data['menteeEmail'].toString(),
//                                     child: Text(document.data['menteeEmail']
//                                         .toString()));
//                               }).toList()),
//                           Padding(
//                             padding: const EdgeInsets.all(30.0),
//                             child: RaisedButton(
//                               child: Text(
//                                 "Send Email to inform",
//                                 style: TextStyle(
//                                   fontSize: 18.0,
//                                   fontFamily: 'BalooTamma',
//                                 ),
//                               ),
//                               color: Colors.blue,
//                               textColor: Colors.white,
//                               elevation: 7.0,
//                               onPressed: () {
//                                 _formKey.currentState.validate();
//                                 if (_formKey.currentState.validate()) {
//                                   customLaunch(
//                                       'mailto:$recipientEmail?subject=New Appointment }');

//                                   Navigator.pushReplacement(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (BuildContext context) =>
//                                               HomePage()));
//                                 }
//                               },
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 }
//               }),
//         ),
//       ),
//     );
//   }
// }

// class Data {
//   List<String> topic;
//   List<String> content;

//   Data.fromMap(Map<dynamic, dynamic> data)
//       : topic = data["emailTopic"],
//         content = data["emailContent"];
// }

// class DataList {
//   List<String> topic = new List<String>();
//   List<String> content = new List<String>();

//   DataList.fromSnapshot(DocumentSnapshot snapshot)
//       : topic = List.from(snapshot['emailTopic']),
//         content = List.from(snapshot['emailContent']);
// }
