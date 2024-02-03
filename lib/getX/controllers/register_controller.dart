import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../values/app_regex.dart';

class RegisterController extends GetxController {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  final RxBool passwordNotifier = true.obs;
  final RxBool confirmPasswordNotifier = true.obs;
  final RxBool fieldValidNotifier = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    initializeControllers();
    super.onInit();
  }

  @override
  void onClose() {
    disposeControllers();
    super.onClose();
  }

  GlobalKey<FormState> getFormKey() => _formKey;

  void initializeControllers() {
    nameController = TextEditingController()..addListener(controllerListener);
    emailController = TextEditingController()..addListener(controllerListener);
    passwordController = TextEditingController()
      ..addListener(controllerListener);
    confirmPasswordController = TextEditingController()
      ..addListener(controllerListener);
  }

  void disposeControllers() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void controllerListener() {
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (name.isEmpty &&
        email.isEmpty &&
        password.isEmpty &&
        confirmPassword.isEmpty) return;

    if (AppRegex.emailRegex.hasMatch(email) &&
        AppRegex.passwordRegex.hasMatch(password) &&
        AppRegex.passwordRegex.hasMatch(confirmPassword)) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }
  }

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Error creating account: $e');
      return null;
    }
  }
}
