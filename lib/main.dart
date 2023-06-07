import 'package:flutter/material.dart';
import 'package:gncms_clone/academic_calender/calendar_screen.dart';
import 'package:gncms_clone/academic_calender/complex_calendar.dart';

import 'package:gncms_clone/attendance/details/details_screen.dart';
import 'package:gncms_clone/fees/fees_screen.dart';
import 'package:gncms_clone/custom_widgets/profile_card.dart';
import 'package:gncms_clone/initial_data.dart';
import 'package:gncms_clone/teacher/teacher_home_screen.dart';
import 'package:gncms_clone/teacher/teacher_time_table_screen.dart';
import 'package:gncms_clone/time_table/time_table_screen.dart';
import 'package:gncms_clone/user_login_in/screen_decider.dart';
import 'package:gncms_clone/user_login_in/screens/forgot_password_page.dart';
import 'package:gncms_clone/user_login_in/screens/forgot_password_verification_page.dart';
import 'package:gncms_clone/user_login_in/screens/login_page.dart';
import 'package:gncms_clone/user_login_in/screens/splash_screen.dart';
import 'student_home_screen.dart';
import 'attendance/attendance_screen.dart';
import 'attendance/details/subject_wise.dart';
import 'attendance/details/day_wise.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => InitialData(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GNCMS',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: SplashScreen.id,
        routes: {
          StudentHomeScreen.id: (context) => const StudentHomeScreen(),
          TimeTableScreen.id: (context) => const TimeTableScreen(),
          ProfileCardScreen.id: (context) => const ProfileCardScreen(),
          AttendanceScreen.id: (context) => const AttendanceScreen(),
          FeeScreen.id: (context) => const FeeScreen(),
          SubjectWiseDetails.id: (context) => const SubjectWiseDetails(),
          DayWiseDetails.id: (context) => const DayWiseDetails(),
          DetailsScreen.id: (context) => const DetailsScreen(),
          ForgotPasswordVerificationScreen.id: (context) =>
              const ForgotPasswordVerificationScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          ForgotPasswordScreen.id: (context) => const ForgotPasswordScreen(),
          SplashScreen.id: (context) => const SplashScreen(),
          ScreenDecider.id: (context) => const ScreenDecider(),
          TeacherHomeScreen.id: (context) => const TeacherHomeScreen(),
          TeacherTimeTableScreen.id: (context) =>
              const TeacherTimeTableScreen(),
          HomeCalendarScreen.id: (context) => const HomeCalendarScreen(),
          TableComplexExample.id: (context) => const TableComplexExample(),
        },
      ),
    );
  }
}
