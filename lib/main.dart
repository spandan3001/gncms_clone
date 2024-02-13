import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gncms_clone/academic_calender/calendar_screen.dart';
import 'package:gncms_clone/academic_calender/complex_calendar.dart';
import 'package:gncms_clone/fees/fees_screen.dart';
import 'package:gncms_clone/custom_widgets/profile_card.dart';
import 'package:gncms_clone/getX/route/app_routes.dart';
import 'package:gncms_clone/initial_data.dart';
import 'package:gncms_clone/getX/views/teacher_home_screen.dart';
import 'package:gncms_clone/teacher/teacher_time_table_screen.dart';
import 'package:gncms_clone/time_table/time_table_screen.dart';
import 'package:gncms_clone/user_login_in/screen_decider.dart';
import 'package:gncms_clone/user_login_in/screens/forgot_password_page.dart';
import 'package:gncms_clone/user_login_in/screens/forgot_password_verification_page.dart';
import 'package:gncms_clone/getX/views/splash_screen.dart';
import 'getX/data/binding/app_binding.dart';
import 'getX/utils/helpers/snackbar_helper.dart';
import 'getX/values/app_theme.dart';
import 'getX/views/student_home_screen.dart';
import 'attendance/attendance_screen.dart';
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
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GNCMS',
        initialBinding: HomeBinding(),
        scaffoldMessengerKey: SnackBarHelper.key,
        theme: AppTheme.themeData,
        initialRoute: AppRoutes.getSplashRoute,
        getPages: AppRoutes.pages,
        routes: {
          TimeTableScreen.id: (context) => const TimeTableScreen(),
          ProfileCardScreen.id: (context) => const ProfileCardScreen(),
          AttendanceScreen.id: (context) => const AttendanceScreen(),
          FeeScreen.id: (context) => const FeeScreen(),
          ForgotPasswordVerificationScreen.id: (context) =>
              const ForgotPasswordVerificationScreen(),
          ForgotPasswordScreen.id: (context) => const ForgotPasswordScreen(),
          SplashScreen.id: (context) => const SplashScreen(),
          ScreenDecider.id: (context) => const ScreenDecider(),
          TeacherTimeTableScreen.id: (context) =>
              const TeacherTimeTableScreen(),
          HomeCalendarScreen.id: (context) => const HomeCalendarScreen(),
          TableComplexExample.id: (context) => const TableComplexExample(),
        },
      ),
    );
  }
}
