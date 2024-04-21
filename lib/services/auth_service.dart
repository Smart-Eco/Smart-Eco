import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //sign up function

  Future<void> signUp(String email, String password) async {
    try {
      print('function started');
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Do something after successful sign-in
    } catch (error) {
      print(error);

      const SnackBar(content: Text('Error'));
    }
  }

  // sign in function

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

    
     
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Handle the case when the user is not found

        const SnackBar(content: Text('No user found with that email address.'));
      } else if (e.code == 'wrong-password') {
        const SnackBar(content: Text('Wrong password provided for that user'));
        // Handle the case when the password is incorrect
      } else {
        // Handle other exceptions
        const SnackBar(
            content: Text('An error occurred, please try again later.'));
      }
    } catch (e) {
      // Handle other exceptions
      const SnackBar(content: Text('please try again later'));
    }
  }

  // logout function

  Future<void> logout(BuildContext context) async {
    _firebaseAuth.signOut().then((value) {
      Navigator.pushNamedAndRemoveUntil(context, '/signout', (route) => false);
    });
  }
}
