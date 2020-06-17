import 'package:flutter/material.dart';
import 'package:mentor_program/shared/constants.dart';
import 'services/usermanagement.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MentorSignUp extends StatefulWidget {
  @override
  _MentorSignUpState createState() => _MentorSignUpState();
}

class _MentorSignUpState extends State<MentorSignUp> {
  final _formKey = GlobalKey<FormState>();
  UserManagement userManagement = new UserManagement();
  String email;
  String password;
  String nickName;
  String menteeName;
  String error;
  String role;
  String selectedRole;
  String admin;
  String mentorName;
  bool loading = false;
  String education;
  String interest1;
  String interest2;
  String hobby1;
  String hobby2;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new SingleChildScrollView(
      child: new Container(
          padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
          child: new Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // SizedBox(height: 20.0),
                  Text(
                    'Register Staff',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'BalooTamma'),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (value) =>
                          value.isEmpty ? 'Enter E-mail' : null,
                      onChanged: (value) {
                        setState(() => email = value);
                      }),
                  TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      validator: (value) => value.length < 6
                          ? 'Enter a password 6 characters or longer'
                          : null,
                      obscureText: true,
                      onChanged: (value) {
                        setState(() => password = value);
                      }),
                  TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Full Name'),
                      validator: (value) =>
                          value.length != 0 ? null : 'Enter full name',
                      onChanged: (value) {
                        setState(() => nickName = value);
                      }),
                  TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Education'),
                      validator: (value) =>
                          value.length != 0 ? null : 'Enter education',
                      onChanged: (value) {
                        setState(() => education = value);
                      }),
                  TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Interest 1'),
                      validator: (value) =>
                          value.length != 0 ? null : 'Enter interest',
                      onChanged: (value) {
                        setState(() => interest1 = value);
                      }),
                  TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Interest 2'),
                      validator: (value) =>
                          value.length != 0 ? null : 'Enter interest',
                      onChanged: (value) {
                        setState(() => interest2 = value);
                      }),
                  TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Hobby 1'),
                      validator: (value) =>
                          value.length != 0 ? null : 'Enter hobby',
                      onChanged: (value) {
                        setState(() => hobby1 = value);
                      }),
                  TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Hobby 2'),
                      validator: (value) =>
                          value.length != 0 ? null : 'Enter hobby',
                      onChanged: (value) {
                        setState(() => hobby2 = value);
                      }),
                  DropdownButtonFormField<String>(
                    decoration: textInputDecoration.copyWith(hintText: 'Role'),
                    validator: (value) =>
                        value == null ? 'Select a role' : null,
                    onChanged: (value) {
                      setState(() => role = value);
                    },
                    items: ['Admin', 'Mentor']
                        .map<DropdownMenuItem<String>>((String roles) {
                      return DropdownMenuItem<String>(
                        value: roles,
                        child: Text(roles),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10.0),
                  RaisedButton(
                      child: Text('Sign Up Staff'),
                      color: Colors.blue,
                      textColor: Colors.white,
                      elevation: 7.0,
                      onPressed: () async {
                        _formKey.currentState.validate();
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email, password: password)
                              .then((signedInUser) async {
                            var userUpdateInfo = new UserUpdateInfo();
                            userUpdateInfo.displayName = nickName;
                            userUpdateInfo.photoUrl =
                                'https://www.vippng.com/png/detail/363-3631840_profile-icon-png-profile-icon-png-white-transparent.png';
                            await signedInUser.user
                                .updateProfile(userUpdateInfo);
                            await signedInUser.user.reload();
                            FirebaseUser updatedUser =
                                await FirebaseAuth.instance.currentUser();
                            print('UserName Is: ${updatedUser.displayName}');
                          }).then((user) {
                            FirebaseAuth.instance.currentUser().then((user) {
                              UserManagement().storeNewMentor(
                                  user,
                                  context,
                                  role,
                                  password,
                                  education,
                                  interest1,
                                  interest2,
                                  hobby1,
                                  hobby2);
                            }).catchError((e) {
                              print(e);
                            });
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
                  SizedBox(height: 10.0),
                  RaisedButton(
                    child: Text('Sign Out'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    elevation: 7.0,
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((val) {
                        Navigator.of(context)
                            .pushReplacementNamed('/landingpage');
                      }).catchError((e) {
                        print(e);
                      });
                    },
                  ),
                ],
              ))),
    ));
  }
}
