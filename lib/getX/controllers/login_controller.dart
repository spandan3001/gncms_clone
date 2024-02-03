import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../values/app_regex.dart';

class LoginController extends GetxController {
  RxBool passwordNotifier = true.obs;
  RxBool fieldValidNotifier = false.obs;

  final _formKey = GlobalKey<FormState>();
  UserType currentSelectUserType = UserType.student;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxString errorMessage = "".obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(controllerListener);
    passwordController.addListener(controllerListener);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  GlobalKey<FormState> getFormKey() => _formKey;

  void controllerListener() {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty && password.isEmpty) {
      fieldValidNotifier.value = false;
      return;
    }

    if (AppRegex.emailRegex.hasMatch(email) &&
        AppRegex.passwordRegex.hasMatch(password)) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }
  }

  Future<User?> signIn() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Successful sign-in, return the authenticated user
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorMessage.value = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage.value = 'Wrong password provided for that user.';
      } else {
        errorMessage.value = 'Error during sign-in: ${e.message}';
      }
      // Return null in case of failure
      return null;
    } catch (e) {
      errorMessage.value = 'Error during sign-in: $e';
      // Return null in case of failure
      return null;
    }
  }
}
