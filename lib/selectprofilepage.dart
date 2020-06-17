import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentor_program/services/usermanagement.dart';

class SelectProfilePage extends StatefulWidget {
  @override
  _SelectProfilePageState createState() => new _SelectProfilePageState();
}

class _SelectProfilePageState extends State<SelectProfilePage> {
  File newProfilePic;
  UserManagement userManagement = new UserManagement();
  String displayName;
  var email;

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      newProfilePic = tempImage;
    });
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        // email = user.email;
        displayName = user.displayName;
      });
    });
  }

  uploadImage() async {
    var randomno = Random();
    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child(
            'profilepics/$displayName/${randomno.nextInt(50000).toString()}.jpg');
    StorageUploadTask task = firebaseStorageRef.putFile(newProfilePic);
    StorageTaskSnapshot snapshottask = await task.onComplete;
    String downloadUrl = await snapshottask.ref.getDownloadURL();
    if (downloadUrl != null) {
      UserManagement().updateProfilePic(downloadUrl.toString()).then((val) {
        Navigator.of(context).pushReplacementNamed('/homepage');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: newProfilePic == null ? getChooseButton() : getUploadButton());
  }

  Widget getChooseButton() {
    return new Stack(
      children: <Widget>[
        ClipPath(
          child: Container(color: Colors.blue[700]),
          clipper: GetClipper(),
        ),
        Positioned(
          width: 390.0,
          top: MediaQuery.of(context).size.height / 5,
          child: Column(
            children: <Widget>[
              Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                          image: NetworkImage(''), fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(75.0)),
                      boxShadow: [
                        BoxShadow(blurRadius: 7.0, color: Colors.black)
                      ])),
              SizedBox(height: 110.0),
              Text(
                'Select a picture',
                style: TextStyle(
                    fontSize: 30.0,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'BalooTamma'),
              ),
              SizedBox(height: 100.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                      height: 40.0,
                      width: 100.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.blueAccent,
                        color: Colors.blue,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: getImage,
                          child: Center(
                            child: Text(
                              'Choose Picture',
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
                            Navigator.of(context)
                                .pushReplacementNamed('/homepage');
                          },
                          child: Center(
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'BalooTamma'),
                            ),
                          ),
                        ),
                      ))
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget getUploadButton() {
    return new Stack(
      children: <Widget>[
        ClipPath(
            child: Container(color: Colors.blue[700]), clipper: GetClipper()),
        Positioned(
          width: 390.0,
          top: MediaQuery.of(context).size.height / 5,
          child: Column(
            children: <Widget>[
              Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                          image: FileImage(newProfilePic), fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(75.0)),
                      boxShadow: [
                        BoxShadow(blurRadius: 7.0, color: Colors.black)
                      ])),
              SizedBox(height: 110.0),
              Text(
                'Upload to proceed',
                style: TextStyle(
                    fontSize: 30.0,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'BalooTamma'),
              ),
              SizedBox(height: 100.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                      height: 40.0,
                      width: 100.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.blueAccent,
                        color: Colors.blue,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: uploadImage,
                          child: Center(
                            child: Text(
                              'Upload',
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
                            Navigator.of(context)
                                .pushReplacementNamed('/homepage');
                          },
                          child: Center(
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'BalooTamma'),
                            ),
                          ),
                        ),
                      ))
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class GetClipper extends CustomClipper<Path> {
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
