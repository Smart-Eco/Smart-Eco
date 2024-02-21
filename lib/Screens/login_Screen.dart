import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarteco2/Screens/base_nav.dart';

class loginScreen extends StatelessWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'SmartEco',
                      style: GoogleFonts.rubik(
                        color: Color.fromARGB(133, 0, 0, 0),
                        fontSize: 48,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Email id',
                        hintText: 'abc@gmail.com',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.lightGreen, width: 2.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: '••••••••',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.lightGreen, width: 2.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Login Button
                  ElevatedButton(
                    onPressed: () {
                      // Handle Login logic
                    },
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      // Implement forgot password logic here
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Horizontal line and "OR" text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // "Sign Up with Google" button
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => basenav()));
                    },
                    icon: Image.asset(
                      'assets/google.jpg',
                      width: 24,
                      height: 24,
                    ),
                    label: Text('Sign Up with Google'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.grey,
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: loginScreen(),
  ));
}
