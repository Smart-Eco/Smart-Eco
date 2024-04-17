import 'package:flutter/material.dart';

class DeviceDetailsScreen extends StatefulWidget {
  final String deviceName;

  DeviceDetailsScreen({required this.deviceName});

  @override
  _DeviceDetailsScreenState createState() => _DeviceDetailsScreenState();
}

class _DeviceDetailsScreenState extends State<DeviceDetailsScreen> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deviceName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Device Status: ${isSwitched ? 'ON' : 'OFF'}',
              style: TextStyle(fontSize: 24),
            ),
            Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
