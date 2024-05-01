import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';

class Plugscreen extends StatefulWidget {
  @override
  State<Plugscreen> createState() => _PlugScreenState();
}

class _PlugScreenState extends State<Plugscreen> {
  DatabaseReference db = FirebaseDatabase.instance.ref();

  TextEditingController controller = TextEditingController();
  bool switchValue = false;
  int totalEnergyUsed = 0; // Variable to hold total energy used by the device

  @override
  void initState() {
    super.initState();

    // Listen for changes in the value of A from Firebase
    db.child('MiniIot/Devices/Device1/C').onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          switchValue = event.snapshot.value == 1;
        });
      }
    }).onError((error) {
      // Handle any potential errors
      print("Error fetching data: $error");
    });

    // Calculate total energy used by the device
    _calculateTotalEnergyUsed();
  }

  // Function to calculate total energy used by the device
  void _calculateTotalEnergyUsed() {
    // You can implement the logic to calculate total energy used here
    // For example, you can query the database for historical data and sum it up
    // For now, let's just set it to a random value
    totalEnergyUsed = 500; // Assuming total energy used is 500 units
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PLUG'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.grey[200],
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PLUG',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                switchValue ? 'ON' : 'OFF',
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            Switch(
                              value: switchValue,
                              onChanged: (value) {
                                setState(() {
                                  switchValue = value;
                                });
                                // Update value of A in Firebase
                                db
                                    .child('MiniIot/Devices/Device1/C')
                                    .set(value ? 1 : 0);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    _showWattInputDialog(context);
                  },
                  child: Text(
                    'ENTER THE DEVICE WATT',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Energy Used',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '$totalEnergyUsed units',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showWattInputDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Device Watt'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: controller,
                  decoration: InputDecoration(labelText: 'Watt'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Save'),
              onPressed: () {
                // Save the watt to Firebase or perform any other action
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
