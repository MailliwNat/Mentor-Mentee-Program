import 'package:flutter/material.dart';

class PostSubmissionPage extends StatefulWidget {
  @override
  _PostSubmissionPageState createState() => _PostSubmissionPageState();
}

class _PostSubmissionPageState extends State<PostSubmissionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30),
            Text(
              'Submission Successful',
              style: TextStyle(fontFamily: 'BalooTamma', fontSize: 30),
            ),
            RaisedButton(
              child: Text('Back to Home Page'),
              color: Colors.blue,
              textColor: Colors.white,
              elevation: 10.0,
              onPressed: () async {
                Navigator.of(context).pushReplacementNamed('/homepage');
              },
            )
          ],
        ),
      ),
    );
  }
}
