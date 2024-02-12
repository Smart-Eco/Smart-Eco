import 'package:flutter/material.dart';
import 'package:smarteco2/Screens/home_screen.dart';

class basenav extends StatefulWidget {
  const basenav({Key? key}) : super(key: key);

  @override
  _BaseNavState createState() => _BaseNavState();
}

class _BaseNavState extends State<basenav> {
  int _currentIndex = 0; // Add this line to track the current index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        selectedItemColor: Colors.white,
        unselectedItemColor: Color.fromARGB(255, 117, 117, 117),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            // Handle navigation item taps here
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
                break;
              case 1:
                // Navigate to the profile page
                break;
              case 2:
                // Navigate to the notifications page
                break;
            }
          });
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: basenav(),
  ));
}
