import 'package:flutter/material.dart';

class RegisterRoomScreen extends StatefulWidget {
  final int numberOfRooms;

  RegisterRoomScreen({required this.numberOfRooms});

  @override
  _RegisterRoomScreenState createState() => _RegisterRoomScreenState();
}

class _RegisterRoomScreenState extends State<RegisterRoomScreen> {
  List<TextEditingController> roomControllers = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.numberOfRooms; i++) {
      roomControllers.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Rooms'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter room names:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            // Generate text fields for room names
            for (int i = 0; i < widget.numberOfRooms; i++)
              TextField(
                controller: roomControllers[i],
                decoration: InputDecoration(
                  labelText: 'Room ${i + 1}',
                  hintText: 'Enter name for Room ${i + 1}',
                ),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle registration logic here
                // You can access room names using roomControllers[i].text
              },
              child: Text('Register Rooms'),
            ),
          ],
        ),
      ),
    );
  }
}
