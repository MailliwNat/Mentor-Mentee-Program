import 'dart:io';
import 'dart:math';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mentor_program/mentorEditInfo.dart';
import 'package:mentor_program/mentorViewInfo.dart';
import 'package:mentor_program/services/usermanagement.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File newProfilePic;
  var profilePicUrl =
      'https://jeffreycheah.foundation/wp-content/uploads/2015/06/trustees_Jeffrey_Cheah.jpg';
  var nickName = '';
  File selectedImage;
  UserManagement userManagement = new UserManagement();
  String newNickName;
  String displayName;
  String email;
  String uid;

  List<NetworkImage> _listOfImages = <NetworkImage>[];

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        displayName = user.displayName;
        uid = user.uid;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  uploadImage() async {
    var randomno = Random(25);
    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child(
            'profilepics/$displayName/${randomno.nextInt(5000).toString()}.jpg');
    StorageUploadTask task = firebaseStorageRef.putFile(newProfilePic);
    StorageTaskSnapshot snapshottask = await task.onComplete;
    String downloadUrl = await snapshottask.ref.getDownloadURL();
    if (downloadUrl != null) {
      userManagement.updateProfilePic(downloadUrl.toString()).then((val) {
        Navigator.of(context).pushReplacementNamed('/homepage');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('/staff')
            .where('uid', isEqualTo: uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                ClipPath(
                  child: Container(color: Colors.blue[700]),
                  clipper: getClipper(),
                ),
                ListView.builder(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshot.data.documents[index];
                    _listOfImages = [];
                    for (int i = 0;
                        i < documentSnapshot.data['photoUrl'].length;
                        i++) {
                      _listOfImages.add(
                          NetworkImage(documentSnapshot.data['photoUrl'][i]));
                    }
                    return Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: [
                                SizedBox(
                                  height: 360.0,
                                  width: 392.7,
                                  child: Carousel(
                                    showIndicator: true,
                                    boxFit: BoxFit.fill,
                                    autoplay: true,
                                    autoplayDuration:
                                        const Duration(seconds: 6),
                                    images: _listOfImages,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              documentSnapshot['displayName'],
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'BalooTamma'),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 60.0),
                            Text(
                              documentSnapshot['email'],
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'BalooTamma'),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 90.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    height: 40.0,
                                    width: 100.0,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(20.0),
                                      shadowColor: Colors.greenAccent,
                                      color: Colors.green,
                                      elevation: 7.0,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          MentorViewInfo()));
                                        },
                                        child: Center(
                                          child: Text(
                                            'Edit Info',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'BalooTamma'),
                                          ),
                                        ),
                                      ),
                                    )),
                                Container(
                                    height: 40.0,
                                    width: 100.0,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(20.0),
                                      shadowColor: Colors.blueAccent,
                                      color: Colors.blue,
                                      elevation: 7.0,
                                      child: GestureDetector(
                                        onTap: () {
                                          UserManagement()
                                              .authorizeButton(context);
                                        },
                                        child: Center(
                                          child: Text(
                                            'Add Picture',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'BalooTamma'),
                                          ),
                                        ),
                                      ),
                                    )),
                                Container(
                                    height: 40.0,
                                    width: 100.0,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(20.0),
                                      shadowColor: Colors.redAccent,
                                      color: Colors.red,
                                      elevation: 7.0,
                                      child: GestureDetector(
                                        onTap: () {
                                          FirebaseAuth.instance
                                              .signOut()
                                              .then((val) {
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    '/landingpage');
                                          }).catchError((e) {
                                            print(e);
                                          });
                                        },
                                        child: Center(
                                          child: Text(
                                            'Sign Out',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'BalooTamma'),
                                          ),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ));
                  },
                )
              ],
            );
          } else {
            return new Text(
              'Loading',
              style: TextStyle(color: Colors.white, fontFamily: 'BalooTamma'),
            );
          }
        },
      ),
    );
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
