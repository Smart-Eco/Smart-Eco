import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';

class PlugScreen extends StatefulWidget {
  @override
  State<PlugScreen> createState() => _PlugScreenState();
}

class _PlugScreenState extends State<PlugScreen> {
  DatabaseReference db = FirebaseDatabase.instance.ref();

  TextEditingController controller = TextEditingController();
  bool switchValue = false;
  int totalEnergyUsed = 0; // Variable to hold total energy used by the device
  int totalTime = 0; // Variable to hold total time

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

    // Update total energy used in the database
    _updateTotalEnergyUsed(totalEnergyUsed);
  }

  // Function to update total energy used in the database
  void _updateTotalEnergyUsed(int energy) {
    db.child('MiniIot/Devices/Device1/energy/C').set(energy);
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
            StreamBuilder(
                stream: db.child('MiniIot/Devices/Device1/logs/C').onValue,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData ||
                      snapshot.data!.snapshot.value == null) {
                    return Text('No data available');
                  } else {
                    Map<dynamic, dynamic> data = snapshot.data!.snapshot.value;
                    List<Widget> dataList = [];
                    List<int> statusList = [];
                    List<int> updatedList = [];
                    List<Duration> durationList = [];
                    List<DateTime> updatedListDateTime = [];
                    Duration totalDuration = Duration.zero;

                    data.forEach((key, value) {
                      dataList.add(Text(
                          'ID: $key, Updated: ${value['updated']}, Status: ${value['status']}'));
                      statusList.add(value['status']);
                      int updatedValue;
                      try {
                        updatedValue = int.parse(value['updated']);
                        updatedList.add(updatedValue);
                      } catch (e) {
                        print('Error parsing updated value for key $key: $e');
                      }
                    });
                    updatedList.sort();
                    updatedList = updatedList.reversed.toList();
                    print('time ${updatedList}');

                    for (int i = 0; i < updatedList.length; i++) {
                      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                          updatedList[i] * 1000,
                          isUtc: true);
                      updatedListDateTime.add(dateTime);
                    }
                    print('updatedListDateTime${updatedListDateTime}');

                    for (int i = 0; i < updatedList.length - 1; i = i + 2) {
                      durationList.add(updatedListDateTime[i]
                          .difference(updatedListDateTime[i + 1]));
                    }
                    print('duration: $durationList');

                    for (var duration in durationList) {
                      totalDuration += duration;
                    }
                    totalTime = totalDuration.inSeconds;
                    print('totalTime: $totalTime');
                    return Text(
                      "${totalTime} sec",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 19, 18, 18),
                      ),
                      textAlign: TextAlign.left,
                    );
                  }
                }),
            SizedBox(height: 20),
            StreamBuilder(
              stream: db.child('MiniIot/Devices/Device1/Watt/C').onValue,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData ||
                    snapshot.data!.snapshot.value == null) {
                  return Text('No data available');
                } else {
                  int wattage = snapshot.data!.snapshot.value;
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Device Watt',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '$wattage W',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
            StreamBuilder(
              stream: db.child('MiniIot/Devices/Device1/Watt/C').onValue,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData ||
                    snapshot.data!.snapshot.value == null) {
                  return Text('No data available');
                } else {
                  int wattage = snapshot.data!.snapshot.value;
                  totalEnergyUsed = wattage * totalTime;
                  _updateTotalEnergyUsed(
                      totalEnergyUsed); // Update total energy used in the database
                  return Card(
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
                            '$totalEnergyUsed W',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
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
                int wattage = int.tryParse(controller.text) ?? 0;
                db.child('MiniIot/Devices/Device1/Watt/C').set(wattage);
                controller.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
