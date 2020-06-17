// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mentor_program/homepage.dart';
// import 'package:mentor_program/reporting/sendEmailToMentee/emailDrafts.dart';
// import 'package:mentor_program/reporting/sendEmailToMentee/sendEmailPage.dart';

// class ShowDrafts extends StatefulWidget {
//   @override
//   _ShowDraftsState createState() => _ShowDraftsState();
// }

// class Data {
//   final String title;
//   final String content;

//   Data(this.title, this.content);
// }

// class _ShowDraftsState extends State<ShowDrafts> {
//   String email;
//   String displayName;
//   String title;
//   String content;
//   String data;
//   @override
//   void initState() {
//     super.initState();
//     FirebaseAuth.instance.currentUser().then((user) {
//       setState(() {
//         email = user.email;
//         displayName = user.displayName;
//       });
//     });
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
//                     builder: (BuildContext context) => HomePage()))),
//         centerTitle: true,
//         title: Text(
//           'E-mail Drafts',
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: StreamBuilder<QuerySnapshot>(
//             stream: Firestore.instance
//                 .collection('/EmailDrafts')
//                 .where('email', isEqualTo: email)
//                 .snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return ListView.builder(
//                     shrinkWrap: true,
//                     padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                     itemCount: snapshot.data.documents.length,
//                     itemBuilder: (context, index) {
//                       DocumentSnapshot documentSnapshot =
//                           snapshot.data.documents[index];
//                       final data = Data(title, content);
//                       return Padding(
//                         padding: EdgeInsets.all(0),
//                         child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: <Widget>[
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (data) => SendEmailPage()));
//                                 },
//                                 child: Text(
//                                   documentSnapshot['emailTopic'],
//                                   style: TextStyle(
//                                       fontSize: 25.0,
//                                       fontWeight: FontWeight.bold,
//                                       fontFamily: 'BalooTamma'),
//                                 ),
//                               )

//                               // Expanded(
//                               //     child: ListView(
//                               //         children: List.generate(
//                               //   _listOfTopic.length,
//                               //   (index) {
//                               //     return ListTile(
//                               //       onLongPress: () {
//                               //         setState(() {});
//                               //       },
//                               //     );
//                               //   },
//                               // ))),
//                               // Expanded(
//                               //     child: ListView(
//                               //   children: List.generate(
//                               //     _listOfContent.length,
//                               //     (index) {
//                               //       return ListTile(
//                               //         onLongPress: () {
//                               //           setState(() {});
//                               //         },
//                               //       );
//                               //     },
//                               //   ),
//                               // ))
//                             ]),
//                       );
//                     });
//               }
//             }),
//       ),
//       floatingActionButton: FloatingActionButton(
//           child: Icon(Icons.add),
//           onPressed: () => Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                   builder: (BuildContext context) => SaveDrafts()))),
//     );
//   }
// }
