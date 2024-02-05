import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gncms_clone/constants.dart';
import 'package:gncms_clone/getX/controllers/main_controller.dart';
import 'package:gncms_clone/getX/data/model/student_model.dart';
import 'package:gncms_clone/getX/data/model/teacher_model.dart';

class RegisterController extends GetxController {
  final _formKey2 = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final RxBool passwordNotifier = true.obs;
  final RxBool confirmPasswordNotifier = true.obs;
  final RxBool fieldValidNotifier = false.obs;
  Rx<UserType> currentSelectUserType = UserType.student.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onClose() {
    disposeControllers();
    super.onClose();
  }

  GlobalKey<FormState> getFormKey() => _formKey2;

  void disposeControllers() {
    nameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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

  Future<void> setUserModel() async {
    final MainController mainController = Get.find<MainController>();
    try {
      if (mainController.currentUser.value == UserType.teacher) {
        TeacherModel teacherModel = TeacherModel(
            userType: UserType.teacher.name,
            email: emailController.text,
            firstName: nameController.text);
        DocumentSnapshot<Map<String, dynamic>>? doc =
            await mainController.firestoreController.addTeacher(teacherModel);

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
          await mainController.repository
              .setCurrentUserModel(userDataStringMap);

          // Update the current user model in MainController
          mainController.setUserController(
              userDataStringMap, mainController.currentUser.value);
        } else {
          // Handle case when the document doesn't exist or is empty
          print('Document not found or empty');
        }
      } else if (mainController.currentUser.value == UserType.student) {
        StudentModel studentModel = StudentModel(
            userType: UserType.student.name,
            email: emailController.text,
            firstName: nameController.text);
        DocumentSnapshot<Map<String, dynamic>>? doc =
            await mainController.firestoreController.addStudent(studentModel);

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
          await mainController.repository
              .setCurrentUserModel(userDataStringMap);

          // Update the current user model in MainController
          mainController.setUserController(
              userDataStringMap, mainController.currentUser.value);
        } else {
          // Handle case when the document doesn't exist or is empty
          print('Document not found or empty');
        }
      }
    } catch (e) {
      // Handle any errors that may occur during the process
      print('Error setting user model: $e');
    }
  }
}
