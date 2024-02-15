import 'package:get/get.dart';
import 'package:gncms_clone/getX/data/model/teacher_model.dart';

import '../../../data/model/attendance_model.dart';
import '../../../data/model/student_model.dart';
import '../../../route/app_routes.dart';
import '../../main_controller.dart';

class TeacherAttendanceController extends GetxController {
  TeacherAttendanceController({required this.teacherModel});
  List<AttendanceModel> listOfAttendanceModel = [];
  List<StudentModel> students = [];
  List<String> present = [];
  List<String> absent = [];
  final TeacherModel teacherModel;
  Rx<AttendanceModel>? currentAttendanceModel;

  Future<void> goToMarkAttendanceScreen(AttendanceModel attendanceModel,
      String dayModelId, String slotModelId) async {
    await getStudents(
        branch: attendanceModel.branch,
        semester: attendanceModel.semester,
        section: attendanceModel.section);
    Get.toNamed(AppRoutes.getMarkAttendanceScreen, arguments: {
      'attendanceModelId': attendanceModel.id,
      'attendanceDayModelId': dayModelId,
      'attendanceSlotModelId': slotModelId
    });
  }

  Future<void> getStudents(
      {required String branch,
      required String semester,
      required String section}) async {
    final mainController = Get.find<MainController>();
    final (students, studentIds) = await mainController.firestoreController
        .getStudentList(branch: branch, semester: semester, section: section);
    this.students = students;
    absent = studentIds;
  }

  Future<void> getListOfAttendanceModel() async {
    final mainController = Get.find<MainController>();
    listOfAttendanceModel = await mainController.firestoreController
        .getListOfAttendanceModel(teacherModel);
  }

  Future<void> goNextSecSemScreen(
      {required String section, required String semester}) async {
    final mainController = Get.find<MainController>();
    final attendanceModel = await mainController.firestoreController
        .getListOfAttendanceDayModelForAttendanceModel(
            listOfAttendanceModel: listOfAttendanceModel,
            semester: semester,
            section: section,
            teacherModel: teacherModel);
    currentAttendanceModel = attendanceModel.obs;
    Get.toNamed(AppRoutes.getClassListInSemesterSectionScreen);
  }

  Future<void> reloadAttendanceModelAndGoBack() async {
    currentAttendanceModel!.value.days.clear();
    final mainController = Get.find<MainController>();

    final attendanceModel = await mainController.firestoreController
        .getListOfAttendanceDayModelForAttendanceModel(
            listOfAttendanceModel: listOfAttendanceModel,
            semester: currentAttendanceModel!.value.semester,
            section: currentAttendanceModel!.value.section,
            teacherModel: teacherModel);
    currentAttendanceModel!.value = attendanceModel;
    Get.back();
  }
}
