import 'package:flutter/material.dart';

class ProfileScrn extends StatefulWidget {
  const ProfileScrn({Key? key}) : super(key: key);

  @override
  State<ProfileScrn> createState() => _ProfileScrnState();
}

class _ProfileScrnState extends State<ProfileScrn> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                        'assets/profile_image.jpg'), // Replace with your profile image
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
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
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(5),
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 15, // Adjust the size of the icon
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Random Username', // Replace with the actual username
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'random@example.com', // Replace with the actual email
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 20),
              buildButton('Edit Profile', Icons.arrow_forward),
              buildButton('Settings', Icons.arrow_forward),
              buildButton('Support', Icons.arrow_forward),
              buildButton('Logout', Icons.arrow_forward),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(String label, IconData icon) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: ElevatedButton(
        onPressed: () {
          // Handle button click
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Icon(icon),
          ],
        ),
        style: ElevatedButton.styleFrom(
          fixedSize: Size(200, 50), // Adjust width and height as needed
        ),
      ),
    );
  }
}
