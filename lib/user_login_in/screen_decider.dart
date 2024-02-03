import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gncms_clone/student_home_screen.dart';
import 'package:gncms_clone/teacher/teacher_home_screen.dart';
import 'package:gncms_clone/getX/views/login_screen.dart';

import '../constants.dart';
import '../initial_data.dart';

class ScreenDecider extends StatefulWidget {
  const ScreenDecider({Key? key}) : super(key: key);
  static const id = '/';

  @override
  State<ScreenDecider> createState() => _ScreenDeciderState();
}

class _ScreenDeciderState extends State<ScreenDecider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData &&
              InitialData.globalCurrentUser == UserType.student.name) {
            return const StudentHomeScreen();
          } else if (snapshot.hasData &&
              InitialData.globalCurrentUser == UserType.teacher.name) {
            return const TeacherHomeScreen();
          } else {
            return const LoginScreen();
          }
        },
        stream: FirebaseAuth.instance.authStateChanges(),
      ),
    );
  }
}
