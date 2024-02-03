import 'package:get/get.dart';
import 'package:gncms_clone/getX/views/register_screen.dart';
import 'package:gncms_clone/teacher/teacher_home_screen.dart';
import 'package:gncms_clone/getX/views/login_screen.dart';
import 'package:gncms_clone/getX/views/splash_screen.dart';

import '../../student_home_screen.dart';

class AppRoutes {
  static const _studentHomeScreen = '/home';
  static const _teacherHomeScreen = '/home';
  static const _splashScreen = '/';
  static const _loginScreen = '/login';
  static const _registerScreen = '/register';

  static String getStudentHomeRoute() => _studentHomeScreen;
  static String getTeacherHomeRoute() => _studentHomeScreen;
  static String getSplashRoute() => _splashScreen;
  static String getRegisterRoute() => _registerScreen;
  static String getLoginRoute() => _loginScreen;

  static final List<GetPage> pages = [
    GetPage(name: _studentHomeScreen, page: () => const StudentHomeScreen()),
    GetPage(name: _splashScreen, page: () => const SplashScreen()),
    GetPage(name: _loginScreen, page: () => const LoginScreen()),
    GetPage(name: _registerScreen, page: () => const RegisterScreen()),
    GetPage(name: _teacherHomeScreen, page: () => const TeacherHomeScreen()),
  ];
}
