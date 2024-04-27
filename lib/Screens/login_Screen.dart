import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarteco2/Screens/base_nav.dart';
import 'package:smarteco2/Screens/sign_up.dart';
import 'package:smarteco2/services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
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
                        color: const Color.fromARGB(133, 0, 0, 0),
                        fontSize: 48,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email id',
                        hintText: 'abc@gmail.com',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.lightGreen, width: 2.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: '••••••••',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.lightGreen, width: 2.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Login Button
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        if (passwordController.text.isEmpty ||
                            emailController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Field is empty')),
                          );
                        } else {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          // If login successful, navigate to HomeScreen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BaseNav()),
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found' ||
                            e.code == 'wrong-password') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Invalid email or password')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Error occurred. Please try again later.')),
                          );
                        }
                      }
                    },
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(52, 224, 161, 1),
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // "Sign Up" and "Forgot Password?" TextButtons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Handle Sign Up navigation
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()),
                          );
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(width: 2),
                      TextButton(
                        onPressed: () {
                          // Implement forgot password logic here
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  // ... (unchanged code)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
