import 'package:flutter/material.dart';
import 'package:gncms_clone/admin/admin_login.dart';
import 'package:gncms_clone/attendance/details/details_screen.dart';
import 'package:gncms_clone/fees/fees_screen.dart';
import 'package:gncms_clone/profile_card.dart';
import 'package:gncms_clone/time_table/tab_bar.dart';
import 'home_screen.dart';
import 'attendance/attendance_screen.dart';
import 'attendance/details/subject_wise.dart';
import 'attendance/details/day_wise.dart';
import 'package:firebase_core/firebase_core.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GNCMS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/adminLogin',
      routes: {
        '/': (context) => const HomeScreen(),
        '/adminLogin': (context) => AdminLogin(),
        '/timeTable': (context) => const TabBarPage(),
        '/profile': (context) => const ProfileCard(),
        '/attendanceScreen': (context) => const AttendanceScreen(),
        '/fees': (context) => const FeeScreen(),
        '/attendance/details/subject_wise': (context) =>
            const SubjectWiseDetails(),
        '/attendance/details/day_wise': (context) => const DayWiseDetails(),
        '/attendance/details': (context) => const DetailsScreen(),
      },
    );
  }
}
