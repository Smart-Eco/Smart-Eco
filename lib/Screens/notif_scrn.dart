import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child('MiniIot/Devices/Device1/MV');

  Timer? _timer;
  bool _noMotionDetected = false;

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  void _startListening() {
    databaseReference.onValue.listen((event) {
      final motionValue = event.snapshot.value ?? 0;
      if (motionValue == 0) {
        if (!_noMotionDetected) {
          // Start the timer only when motion value changes from 1 to 0
          setState(() {
            _noMotionDetected = true;
          });
          _startTimer();
        }
      } else {
        // Cancel the timer if motion value changes back to 1
        setState(() {
          _noMotionDetected = false;
        });
        _resetTimer();
      }
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: 60), () {
      // Print the message if no motion detected for 60 seconds
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('No Motion Detected'),
            content: Text('No motion detected for last 2 minutes'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      setState(() {
        _noMotionDetected = false;
      });
    });
  }

  void _resetTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: Center(
        child: _noMotionDetected
            ? CircularProgressIndicator() // Show a loading indicator
            : Container(), // Empty container to not display anything
      ),
    );
  }
}
