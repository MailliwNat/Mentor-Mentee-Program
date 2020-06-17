import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentor_program/services/usermanagement.dart';
import 'package:mentor_program/shared/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String error;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
        //called when app is active
        onMessage: (Map<String, dynamic> message) async {
      print('onMessage:$message');
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: Text(message['notification']['title']),
                content: Text(message['notification']['body']),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok'))
                ]);
          });
    },
        //called when app is closed and open with push notification
        onLaunch: (Map<String, dynamic> message) async {
      print('onLaunch:$message');
    },
        //called when app is open in the background
        onResume: (Map<String, dynamic> message) async {
      print('onResume:$message');
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Center(
      child: new Container(
          padding: EdgeInsets.all(25.0),
          child: new Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 1.0),
                  Text(
                    'Mentoring Program',
                    style: TextStyle(fontSize: 30.0, fontFamily: 'BalooTamma'),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) =>
                          val.isEmpty ? 'Enter your email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      }),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Password'),
                    validator: (val) => val.length < 6
                        ? 'Your password is ATLEAST 6 characters.'
                        : null,
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                      child: Text('Login'),
                      color: Colors.blue,
                      textColor: Colors.white,
                      elevation: 7.0,
                      onPressed: () async {
                        _formKey.currentState.validate();
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email, password: password)
                              .then((AuthResult auth) {
                            UserManagement().authorizeAccess(context);
                            UserManagement().authorizeNormalAccess(context);
                            UserManagement().authorizeMentorAccess(context);
                          }).catchError((e) {
                            print(e);
                          });
                          if (result == null) {
                            setState(() {
                              error = 'Invalid Credentials';
                              loading = false;
                            });
                          }
                        }
                      }),
                ],
              ))),
    ));
  }
}
