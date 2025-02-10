import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swap_store/pages/auth_screen/required_detail_page.dart';

class AuthendicationService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> createUser(BuildContext context,
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        if (context.mounted) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => RequiredDetailPage()));
        }
      } else {
        if (context.mounted) {
          Get.snackbar("", "Login failed. User does not exist.");
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Login failed. Please try again.";
      if (e.code == 'user-not-found') {
        errorMessage = "User not found. Please register first.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Incorrect password. Please try again.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "Invalid email format.";
      }

      if (context.mounted) {
        Get.snackbar("title", errorMessage.toString());
      }
    }
  }

  Future<void> loginUser(BuildContext context,
      {required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Login failed. Please try again.";
      if (e.code == 'user-not-found') {
        errorMessage = "User not found. Please register first.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Incorrect password. Please try again.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "Invalid email format.";
      }

      if (context.mounted) {
        Get.snackbar("", errorMessage.toString());
      }
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
