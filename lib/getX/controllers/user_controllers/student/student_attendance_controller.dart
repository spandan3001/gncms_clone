import 'package:get/get.dart';
import 'package:gncms_clone/getX/data/model/attendance_model.dart';
import 'package:gncms_clone/getX/data/model/student_attendance_model.dart';
import 'package:gncms_clone/getX/data/model/student_model.dart';

import '../../main_controller.dart';

class StudentAttendanceController extends GetxController {
  StudentAttendanceController({required this.studentModel});
  final StudentModel studentModel;
  final Map<String, dynamic> subjects = {};
  AttendanceModel? attendanceModel;
  StudentAttendanceModel? currentStudentAttendanceModel;
  List<StudentAttendanceModel> listOfStudentAttendance = [];

  void setCurrentStudentAttendanceModel(
      StudentAttendanceModel studentAttendanceModel) {
    currentStudentAttendanceModel = studentAttendanceModel;
  }

  void disposeCurrentStudentAttendanceModel() {
    currentStudentAttendanceModel = null;
  }

  Future<void> getAttendanceList() async {
    final mainController = Get.find<MainController>();
    attendanceModel = await mainController.firestoreController
        .getAttendanceModel(studentModel);
  }

  void getUniqueSubjects() {
    for (final day in attendanceModel!.days) {
      for (final slot in day.slots) {
        if (!subjects.containsKey(slot.class_)) {
          subjects[slot.class_] = slot.subject;
        }
      }
    }
  }

  StudentAttendanceModel calculateStudentAttendance(
      AttendanceModel attendanceModel) {
    final StudentAttendanceModel studentAttendanceModel;
    Map<String, dynamic> subjectAttendance = {};

    void initClass(String class_, String subject) {
      subjectAttendance[class_] = {};
      subjectAttendance[class_]["id"] = "xx";
      subjectAttendance[class_]["subject"] = subject;
      subjectAttendance[class_]["semester"] = studentModel.semester;
      subjectAttendance[class_]["absent"] = 0;
      subjectAttendance[class_]["present"] = 0;
    }

    SemesterAttendanceModel convertToSemesterModel(
        String keyClass_, dynamic value) {
      Map<String, dynamic> newMap = Map<String, dynamic>.from(value);
      newMap['class'] = keyClass_;
      return SemesterAttendanceModel.fromJson(newMap);
    }

    for (var day in attendanceModel.days) {
      //to do implemesnt day till today;
      for (var slot in day.slots) {
        if (!subjectAttendance.containsKey(slot.class_)) {
          initClass(slot.class_, slot.subject);
        }
        if (slot.present.contains(studentModel.id)) {
          subjectAttendance[slot.class_]["present"] += 1;
        } else {
          subjectAttendance[slot.class_]["absent"] += 1;
        }
      }
    }
    List<SemesterAttendanceModel> semesterAttendanceList = [];
    subjectAttendance.forEach((key, value) {
      semesterAttendanceList.add(convertToSemesterModel(key, value));
    });
    studentAttendanceModel = StudentAttendanceModel(
        semester: attendanceModel.semester,
        listOfSemesterAttendance: semesterAttendanceList,
        id: 'x');

    return studentAttendanceModel;
  }

  Future<bool> updateStudentAttendance() async {
    await getAttendanceList();
    getUniqueSubjects();
    final mainController = Get.find<MainController>();

    final result = await mainController.firestoreController
        .addStudentAttendance(
            studentModel, calculateStudentAttendance(attendanceModel!));
    await checkStudentAttendance();
    return result;
  }

  Future<void> checkStudentAttendance() async {
    final mainController = Get.find<MainController>();
    listOfStudentAttendance = await mainController.firestoreController
        .getStudentAttendance(studentModel);

    final tempList = listOfStudentAttendance
        .where((element) => element.semester == studentModel.semester);
    if (tempList.isEmpty) {
      await updateStudentAttendance();
    }
  }
}
