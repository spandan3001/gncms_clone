import 'package:get/get.dart';
import 'package:gncms_clone/attendance/attendance_screen.dart';
import 'package:gncms_clone/attendance/details/subject_wise.dart';
import 'package:gncms_clone/getX/views/class_list.dart';
import 'package:gncms_clone/getX/views/mark_attendance_screen.dart';
import 'package:gncms_clone/getX/views/register_screen.dart';
import 'package:gncms_clone/getX/views/teacher_home_screen.dart';
import 'package:gncms_clone/getX/views/login_screen.dart';
import 'package:gncms_clone/getX/views/splash_screen.dart';

import '../../attendance/details/details_screen.dart';
import '../views/student_home_screen.dart';

class AppRoutes {
  static const _studentHomeScreen = '/studentHome';
  static const _teacherHomeScreen = '/teacherHome';
  static const _splashScreen = '/';
  static const _subjectAttendanceScreen = '/subjectScreen';
  static const _loginScreen = '/login';
  static const _registerScreen = '/register';
  static const _classListInSemesterSectionScreen = '/classListSemesterSection';
  static const _attendanceDetailScreen = '/detail';
  static const _markAttendanceScreen = '/markAttendance';
  static const _studentAttendanceScreen = '/studentAttendance';
  static const _classListScreen = '/classList';

  static String get getStudentHomeRoute => _studentHomeScreen;
  static String get getTeacherHomeRoute => _teacherHomeScreen;
  static String get getSplashRoute => _splashScreen;
  static String get getRegisterRoute => _registerScreen;
  static String get getLoginRoute => _loginScreen;
  static String get getAttendanceDetailScreen => _attendanceDetailScreen;
  static String get getStudentAttendanceScreen => _studentAttendanceScreen;
  static String get getMarkAttendanceScreen => _markAttendanceScreen;
  static String get getSubjectAttendanceScreen => _subjectAttendanceScreen;

  static String get getClassListInSemesterSectionScreen =>
      _classListInSemesterSectionScreen;
  static String get getClassListScreen => _classListScreen;

  static final List<GetPage> pages = [
    GetPage(name: _studentHomeScreen, page: () => const StudentHomeScreen()),
    GetPage(name: _splashScreen, page: () => const SplashScreen()),
    GetPage(name: _loginScreen, page: () => const LoginScreen()),
    GetPage(name: _registerScreen, page: () => const RegisterScreen()),
    GetPage(name: _teacherHomeScreen, page: () => const TeacherHomeScreen()),
    GetPage(name: _attendanceDetailScreen, page: () => const DetailsScreen()),
    GetPage(
        name: _subjectAttendanceScreen, page: () => const SubjectWiseDetails()),
    GetPage(
        name: _studentAttendanceScreen, page: () => const AttendanceScreen()),
    GetPage(name: _classListScreen, page: () => const ClassListScreen()),
    GetPage(
        name: _classListInSemesterSectionScreen,
        page: () => const ClassListInSectionScreen()),
    GetPage(
        name: _markAttendanceScreen, page: () => const MarkAttendanceScreen()),
  ];
}
