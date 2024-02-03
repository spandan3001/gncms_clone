import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gncms_clone/constants.dart';
import 'package:gncms_clone/getX/data/model/student_model.dart';
import 'package:gncms_clone/getX/route/app_routes.dart';
import 'package:gncms_clone/time_table/list_creation.dart';

import '../controllers/main_controller.dart';
import '../data/binding/app_binding.dart';
import '../../initial_data.dart';
import '../data/model/teacher_model.dart';
import '../values/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const id = '/splashScreen';

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;
  SplashScreenState() {
    HomeBinding().dependencies().whenComplete(() {
      MainController mainController = Get.find();

      mainController.repository.getCurrentUserModel().then((userModelMap) {
        if (userModelMap.isEmpty) {
          Get.toNamed(AppRoutes.getLoginRoute());
        } else if (userModelMap['userType'] == UserType.student.name) {
          Get.toNamed(AppRoutes.getStudentHomeRoute());
          mainController.setUserController(
              StudentModel.fromJson(userModelMap), UserType.student);
        } else {
          Get.toNamed(AppRoutes.getTeacherHomeRoute());
          mainController.setUserController(
              TeacherModel.fromJson(userModelMap), UserType.teacher);
        }
      });
    });

    // globalObj.getUser().whenComplete(
    //   () {
    //     Navigator.of(context, rootNavigator: true)
    //         .pushNamedAndRemoveUntil(ScreenDecider.id, (route) => false);
    //   },
    // );

    Timer(const Duration(milliseconds: 10), () {
      setState(() {
        _isVisible =
            true; // Now it is showing fade effect and navigating to Login page
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            //Theme.of(context).colorScheme.secondary, Theme.of(context).primaryColor
            colors: [Colors.lightBlueAccent, Colors.blueAccent],
            begin: FractionalOffset(0, 0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0,
          duration: const Duration(milliseconds: 1200),
          child: Center(
            child: Container(
              height: 140.0,
              width: 140.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 2.0,
                      offset: const Offset(5.0, 3.0),
                      spreadRadius: 2.0,
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 100,
                  child: Image.asset(
                    'assets/tyianlogo.png',
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
