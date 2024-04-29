import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DatabaseReference db = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    final snapshot = await db.child('MiniIot/Devices/Device1').get();
    if (snapshot.exists) {
      print(snapshot.value);
    } else {
      print('No data available.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
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
                DropdownButton<String>(
                  hint: Text('Select Duration'),
                  onChanged: (String? value) {},
                  items:
                      <String>['Last Week', 'Last Month'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 20),
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
                          'Current Usage:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '105.57 kWh',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Container(
                    color: Colors.grey[200],
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Predicted Bill:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Rs. 1349',
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
           
          ],
        ),
      ),
    );
  }
}
