import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gncms_clone/getX/controllers/main_controller.dart';

import '../../constants.dart';
import '../values/app_regex.dart';

class LoginController extends GetxController {
  RxBool passwordNotifier = true.obs;
  RxBool fieldValidNotifier = false.obs;

  final _formKey1 = GlobalKey<FormState>();
  Rx<UserType> currentSelectUserType = UserType.student.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxString errorMessage = "".obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  GlobalKey<FormState> getFormKey() => _formKey1;

  Future<User?> signIn() async {
    try {
      UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .whenComplete(
        () async {
          await setUserModel();
        },
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

  Future<void> setUserModel() async {
    final MainController mainController = Get.find<MainController>();
    try {
      // Get the document from Firestore
      DocumentSnapshot<Map<String, dynamic>>? doc = await mainController
          .firestoreController
          .getDocument(mainController.currentUser.value);

      // Check if the document exists and contains data
      if (doc!.exists && doc.data() != null) {
        // Extract the data from the document
        Map<String, dynamic> userData = doc.data()!;

        // Convert the user data to Map<String, String>
        Map<String, String> userDataStringMap = {};
        userData.forEach((key, value) {
          userDataStringMap[key] = value.toString();
        });

        // Set the current user model in SharedPreferences
        await mainController.repository.setCurrentUserModel(userDataStringMap);

        // Update the current user model in MainController
        mainController.setUserController(
            userDataStringMap, mainController.currentUser.value);
      } else {
        // Handle case when the document doesn't exist or is empty
        print('Document not found or empty');
      }
    } catch (e) {
      // Handle any errors that may occur during the process
      print('Error setting user model: $e');
    }
  }
}
