import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseModel {
  static const branchCollection1 = "Branches";
  static const semesterCollection = "Semesters";
  static const sectionCollection = "Sections";
  static const studentCollection = "Students";
  static const slotCollection = "Slots";
  static const teacherCollection = "Teachers";
  static const timetableCollection = "Timetable";
  static const dayCollection = "Days";
  static const attendanceCollection = "Attendance";
  static const studentAttendanceCollection = "Attendance";

  Map<String, dynamic> branchIds = {};
  Map<String, dynamic> semesterIds = {};
  Map<String, dynamic> sectionIds = {};
}
