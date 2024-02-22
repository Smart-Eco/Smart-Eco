import 'package:flutter/material.dart';
import 'package:smarteco2/Screens/home_screen.dart';
import 'package:smarteco2/Screens/notif_scrn.dart';
import 'package:smarteco2/Screens/profile_scrn.dart';

class BaseNav extends StatefulWidget {
  const BaseNav( {Key? key}) : super(key: key);

  @override
  _BaseNavState createState() => _BaseNavState();
}

class _BaseNavState extends State<BaseNav> {
  int _currentIndex = 0; // Add this line to track the current index
  List screens = [HomeScreen(), NotifScrn(), ProfileScrn()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
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
          });
        },
      ),
    );
  }
}
