import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class TotalEnergyPage extends StatelessWidget {
  final DatabaseReference db = FirebaseDatabase.instance.reference();
  final Function(int) onSumUpdated;

  TotalEnergyPage({required this.onSumUpdated});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Total Energy Page'),
      ),
      body: StreamBuilder(
        stream: db.child('MiniIot/Devices/Device1/energy/A').onValue,
        builder: (context, AsyncSnapshot snapshotA) {
          if (snapshotA.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshotA.hasError) {
            return Text('Error: ${snapshotA.error}');
          } else if (!snapshotA.hasData || snapshotA.data!.snapshot.value == null) {
            return Text('No data available for A');
          } else {
            int valueOfA = snapshotA.data!.snapshot.value;
            return StreamBuilder(
              stream: db.child('MiniIot/Devices/Device1/energy/B').onValue,
              builder: (context, AsyncSnapshot snapshotB) {
                if (snapshotB.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshotB.hasError) {
                  return Text('Error: ${snapshotB.error}');
                } else if (!snapshotB.hasData || snapshotB.data!.snapshot.value == null) {
                  return Text('No data available for B');
                } else {
                  int valueOfB = snapshotB.data!.snapshot.value;
                  return StreamBuilder(
                    stream: db.child('MiniIot/Devices/Device1/energy/C').onValue,
                    builder: (context, AsyncSnapshot snapshotC) {
                      if (snapshotC.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshotC.hasError) {
                        return Text('Error: ${snapshotC.error}');
                      } else if (!snapshotC.hasData || snapshotC.data!.snapshot.value == null) {
                        return Text('No data available for C');
                      } else {
                        int valueOfC = snapshotC.data!.snapshot.value;
                        int totalEnergy = valueOfA + valueOfB + valueOfC;
                        // Store total energy value in the Firebase Realtime Database
                        db.child('MiniIot/Devices/Device1/energy/Tenergy').set(totalEnergy);
                        // Call the callback function to pass the total energy value back to the HomeScreen
                        onSumUpdated(totalEnergy);
                        // No need to display anything in this page
                        return SizedBox();
                      }
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
