import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gncms_clone/getX/controllers/main_controller.dart';
import '../../constants.dart';
import '../route/app_routes.dart';
import '../utils/helpers/snackbar_helper.dart';
import '../values/app_regex.dart';
import '../values/app_strings.dart';

class LoginController extends GetxController {
  RxBool passwordNotifier = true.obs;
  RxBool fieldValidNotifier = false.obs;

  final _formKey1 = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> getFormKey() => _formKey1;

  @override
  void onInit() {
    super.onInit();
    // Add a listener for email and password changes
    emailController.addListener(controllerListener);
    passwordController.addListener(controllerListener);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void controllerListener() {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty && password.isEmpty) return;

    if (AppRegex.emailRegex.hasMatch(email) &&
        AppRegex.passwordRegex.hasMatch(password)) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }
  }

  void logOut() async {
    final MainController mainController = Get.find<MainController>();
    FirebaseAuth.instance.signOut();
    await mainController.repository.disposeUser();
    Get.offNamed(AppRoutes.getLoginRoute);
  }

  Future<User?> signIn() async {
    final MainController mainController = Get.find<MainController>();
    try {
      await _auth
          .signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((value) async {
        if (value.user != null) {
          await setUserModel(value.user!.uid);
          SnackBarHelper.showSnackBar(
            contentType: ContentType.success,
            title: "Success",
            message: AppStrings.loggedIn,
          );
          if (mainController.currentUser.value == UserType.student) {
            Get.offNamed(AppRoutes.getStudentHomeRoute);
          } else if (mainController.currentUser.value == UserType.teacher) {
            Get.offNamed(AppRoutes.getTeacherHomeRoute);
          }
        } else {
          SnackBarHelper.showSnackBar(
            contentType: ContentType.failure,
            title: "Failed",
            message: AppStrings.notLoggedIn,
          );
        }
        return value;
      });
      // Successful sign-in, return the authenticated user
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackBarHelper.showSnackBar(
            title: "Error",
            message: 'No user found for that email.',
            contentType: ContentType.failure);
      } else if (e.code == 'wrong-password') {
        SnackBarHelper.showSnackBar(
            title: "Error",
            message: 'Error during sign-in: ${e.message}',
            contentType: ContentType.failure);
      } else {
        SnackBarHelper.showSnackBar(
            title: "Error",
            message: 'Error during sign-in: ${e.message}',
            contentType: ContentType.failure);
      }
    } catch (e) {
      SnackBarHelper.showSnackBar(
          title: "Error",
          message: 'Error during sign-in: $e',
          contentType: ContentType.failure);
    }
    return null;
  }

  Future<void> setUserModel(String userId) async {
    final MainController mainController = Get.find<MainController>();
    try {
      // Get the document from Firestore
      DocumentSnapshot<Map<String, dynamic>>? doc;

      //get data from firestore
      if (mainController.currentUser.value == UserType.student) {
        final model =
            await mainController.firestoreController.getStudent(userId);
        // Set the current user model in SharedPreferences
        await mainController.repository.setCurrentUserModel(model!.toJson());

        //set user Controller
        mainController.setUserController(model, UserType.student);
      } else if (mainController.currentUser.value == UserType.teacher) {
        final model =
            await mainController.firestoreController.getTeacher(userId);

        // Set the current user model in SharedPreferences
        await mainController.repository.setCurrentUserModel(model!.toJson());

        //set user Controller
        mainController.setUserController(model, UserType.teacher);
      }
    } catch (e) {
      // Handle any errors that may occur during the process
      SnackBarHelper.showSnackBar(
          title: "Error",
          message: 'Error setting user model: $e',
          contentType: ContentType.failure);
    }
  }
}
