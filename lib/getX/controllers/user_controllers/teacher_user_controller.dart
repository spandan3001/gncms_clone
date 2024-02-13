import 'package:get/get.dart';
import 'package:gncms_clone/getX/controllers/main_controller.dart';
import 'package:gncms_clone/getX/controllers/user_controllers/user_type_controller.dart';
import 'package:gncms_clone/getX/data/model/teacher_model.dart';

import '../../data/model/student_model.dart';
import '../../data/model/timetable_model.dart';

class TeacherController extends UserTypeController {
  TeacherModel? _teacherModel;
  List<TimetableModel> listOfTimetableModel = [];
  List<StudentModel> students = [];

  TeacherController({required TeacherModel teacherModel})
      : _teacherModel = teacherModel;

  void setUser(TeacherModel teacherModel) {
    _teacherModel = teacherModel;
  }

  TeacherModel? getUser() {
    return _teacherModel;
  }

  Future<void> getStudents(
      {required String branch,
      required String semester,
      required String section}) async {
    final mainController = Get.find<MainController>();
    students = await mainController.firestoreController
        .getStudentList(branch: branch, semester: semester, section: section);
  }

  Future<void> getListOfTimetableModel() async {
    final mainController = Get.find<MainController>();
    listOfTimetableModel = await mainController.firestoreController
        .getClassForTeacher(teacherModel: _teacherModel!);
  }

  Map<String, List<TimetableModel>> initAttendanceScreen() {
    Map<String, List<TimetableModel>> semesterList = {};

    for (TimetableModel timetableModel in listOfTimetableModel) {
      // Get semester, section, and branch
      String semester = timetableModel.semester;

      // Create or get the map for the semester
      if (semesterList.containsKey(semester)) {
        semesterList[semester]!.add(timetableModel);
      } else {
        semesterList[semester] = [timetableModel];
      }
    }

    return semesterList;
  }

  @override
  void someCommonMethod() {
    // TODO: implement someCommonMethod
  }
}
