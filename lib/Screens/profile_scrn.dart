import 'package:flutter/material.dart';
import 'package:smarteco2/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScrn extends StatefulWidget {
  const ProfileScrn({Key? key}) : super(key: key);

  @override
  _ProfileScrnState createState() => _ProfileScrnState();
}

class _ProfileScrnState extends State<ProfileScrn> {
  String? userName;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    // Fetch user data when the screen initializes
    fetchUserData();
  }

  // Function to fetch user data from Firestore
  void fetchUserData() async {
    // Get current user from FirebaseAuth
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Query Firestore for user's document
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (snapshot.exists) {
        // Set userName and userEmail to user's name and email from Firestore
        setState(() {
          userName = snapshot['name'];
          userEmail = user.email;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(
                      'assets/profile_img.png'), // Replace with your profile image
                ),
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(52, 225, 162, 1),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle camera button click
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(
                          52, 225, 162, 1), // Background color
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(5),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 15, // Adjust the size of the icon
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              userName ?? '', // Display user's name if available, otherwise display empty string
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              userEmail ?? '', // Display user's email if available, otherwise display empty string
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            buildIconButton(Icons.edit, 'Edit Profile', context, () {}),
            const SizedBox(height: 10),
            buildIconButton(Icons.settings, 'Settings', context, () {}),
            const SizedBox(height: 10),
            buildResetButton(context),
            const SizedBox(height: 10),
            buildIconButton(Icons.support, 'Support', context, () {}),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  _showLogoutConfirmationDialog(context);
                },
                child: Text('Logout'))
          ],
        ),
      ),
    );
  }

  Widget buildIconButton(
      IconData icon, String label, BuildContext context, Function onTap) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 10),
                Text(label),
              ],
            ),
            const Icon(Icons.arrow_forward),
          ],
        ),
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(200, 50), // Adjust width and height as needed
        ),
      ),
    );
  }

  Widget buildResetButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: ElevatedButton(
        onPressed: () {
          _showResetDialog(context);
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.restore_page),
                SizedBox(width: 10),
                Text('Reset'),
              ],
            ),
            Icon(Icons.arrow_forward),
          ],
        ),
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(200, 50), // Adjust width and height as needed
        ),
      ),
    );
  }

  Future<void> _showResetDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromRGBO(52, 225, 162, 1),
          title: const Text('Warning'),
          content: const Text('Do you want to reset the bill?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );

    if (result != null && result) {
      // Reset all data
    }
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromRGBO(52, 225, 162, 1),
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );

    if (result != null && result) {
      // Logout
      AuthService auth = AuthService();
      auth.logout(context);
    }
  }
}
