import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gncms_clone/constants.dart';
import 'package:gncms_clone/getX/controllers/main_controller.dart';
import 'package:gncms_clone/getX/data/model/student_model.dart';
import 'package:gncms_clone/getX/data/model/teacher_model.dart';
import '../route/app_routes.dart';
import '../utils/helpers/snackbar_helper.dart';
import '../values/app_regex.dart';
import '../values/app_strings.dart';

class RegisterController extends GetxController {
  final _formKey2 = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController branchController =
      TextEditingController(text: 'CSE');
  final TextEditingController semesterController =
      TextEditingController(text: "1");
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final RxBool passwordNotifier = true.obs;
  final RxBool confirmPasswordNotifier = true.obs;
  final RxBool fieldValidNotifier = false.obs;

  List<String> branches = [];
  List<String> semesters = [];
  GlobalKey<FormState> getFormKey() => _formKey2;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    // Add listeners for name, email, password, and confirmPassword changes
    nameController.addListener(controllerListener);
    branchController.addListener(controllerListener);
    semesterController.addListener(controllerListener);
    emailController.addListener(controllerListener);
    passwordController.addListener(controllerListener);
    confirmPasswordController.addListener(controllerListener);
  }

  @override
  void onClose() {
    disposeControllers();
    super.onClose();
  }

  void disposeControllers() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void getBranches() {}
  void getSemesters() {}

  void controllerListener() {
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    final sem = semesterController.text;
    final branch = branchController.text;

    if (name.isEmpty &&
        email.isEmpty &&
        password.isEmpty &&
        sem.isEmpty &&
        branch.isEmpty &&
        confirmPassword.isEmpty) return;

    if (AppRegex.emailRegex.hasMatch(email) &&
        AppRegex.passwordRegex.hasMatch(password) &&
        AppRegex.passwordRegex.hasMatch(confirmPassword)) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }
  }

  Future<void> signUpWithEmailAndPassword() async {
    final MainController mainController = Get.find<MainController>();
    try {
      await _auth
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then(
        (value) async {
          if (value.user != null) {
            nameController.clear();
            emailController.clear();
            passwordController.clear();
            confirmPasswordController.clear();
            if (await setUserModel()) {
              SnackBarHelper.showSnackBar(
                  contentType: ContentType.success,
                  message: AppStrings.registrationComplete,
                  title: "Success");
              if (mainController.currentUser.value == UserType.student) {
                Get.offAndToNamed(AppRoutes.getStudentHomeRoute);
              } else if (mainController.currentUser.value == UserType.teacher) {
                Get.offAndToNamed(AppRoutes.getTeacherHomeRoute);
              }
            } else {
              SnackBarHelper.showSnackBar(
                  contentType: ContentType.failure,
                  message: "Couldn't register",
                  title: "DataBase Error");
            }
          } else {
            SnackBarHelper.showSnackBar(
                contentType: ContentType.failure,
                message: "Couldn't register",
                title: "failure");
          }
          return value;
        },
      );
    } catch (e) {
      SnackBarHelper.showSnackBar(
          contentType: ContentType.failure,
          message: "$e",
          title: "DataBase Error");
    }
  }

  List<DropdownMenuItem> createDropdownMenuForBranch() {
    return List.generate(
        branches.length,
        (index) => DropdownMenuItem(
              value: branches[index].toString().split('.').last.toUpperCase(),
              child: Text(branches[index].toUpperCase()),
            ));
  }

  List<DropdownMenuItem> createDropdownMenuForSemester() {
    return List.generate(
        semesters.length,
        (index) => DropdownMenuItem(
              value: semesters[index].toString().split('.').last.toUpperCase(),
              child: Text(semesters[index].toUpperCase()),
            ));
  }

  Future<bool> setUserModel() async {
    final MainController mainController = Get.find<MainController>();
    try {
      if (mainController.currentUser.value == UserType.teacher) {
        TeacherModel teacherModel = TeacherModel(
            userType: UserType.teacher.name,
            email: emailController.text,
            firstName: nameController.text,
            id: '',
            branch: branchController.text,
            tId: '');
        DocumentSnapshot<Map<String, dynamic>>? doc = await mainController
            .firestoreController
            .addTeacher(teacherModel)
            .then((value) => value?.get());

        // Check if the document exists and contains data
        if (doc!.exists && doc.data() != null) {
          // Extract the data from the document
          Map<String, dynamic> userData = doc.data()!;

          // Convert the user data to Map<String, String>
          Map<String, String> userDataStringMap = {};
          userData.forEach((key, value) {
            userDataStringMap[key] = value.toString();
          });

          mainController.setUserController(
              teacherModel, mainController.currentUser.value);

          // Set the current user model in SharedPreferences
          return await mainController.repository
              .setCurrentUserModel(userDataStringMap);

          // Update the current user model in MainController
        } else {
          // Handle case when the document doesn't exist or is empty
          SnackBarHelper.showSnackBar(
              contentType: ContentType.failure,
              message: "Document not found or empty",
              title: "DataBase Error");
          return false;
        }
      } else if (mainController.currentUser.value == UserType.student) {
        StudentModel studentModel = StudentModel(
            userType: UserType.student.name,
            email: emailController.text,
            firstName: nameController.text,
            id: '',
            semester: '',
            branch: '',
            section: '',
            usn: '');
        DocumentSnapshot<Map<String, dynamic>>? doc = await mainController
            .firestoreController
            .addStudent(studentModel)
            .then((value) => value?.get());

        // Check if the document exists and contains data
        if (doc!.exists && doc.data() != null) {
          // Extract the data from the document
          Map<String, dynamic> userData = doc.data()!;

          // Convert the user data to Map<String, String>
          Map<String, String> userDataStringMap = {};
          userData.forEach((key, value) {
            userDataStringMap[key] = value.toString();
          });

          mainController.setUserController(
              studentModel, mainController.currentUser.value);

          // Set the current user model in SharedPreferences
          return await mainController.repository
              .setCurrentUserModel(userDataStringMap);

          // Update the current user model in MainController
        } else {
          // Handle case when the document doesn't exist or is empty
          SnackBarHelper.showSnackBar(
              contentType: ContentType.failure,
              message: "Document not found or empty",
              title: "DataBase Error");
          return false;
        }
      }
    } catch (e) {
      // Handle any errors that may occur during the process
      SnackBarHelper.showSnackBar(
          contentType: ContentType.failure,
          message: "Error setting user model: $e",
          title: "Error");
    }
    return false;
  }
}
