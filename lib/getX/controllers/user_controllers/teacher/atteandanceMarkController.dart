import 'package:get/get.dart';
import 'package:gncms_clone/getX/controllers/user_controllers/teacher/teacher_user_controller.dart';

class AttendanceMarkController extends GetxController {
  // RxBool to hold the state of isPresent for this card
  RxBool isPresent = false.obs;

  // Method to get the value of isPresent
  bool getPresentState() {
    return isPresent.value;
  }

  // Method to set the value of isPresent
  void setPresentState(bool value, String studentId) {
    isPresent.value = value;
    addStudentToList(studentId);
  }

  void addStudentToList(String studentId) {
    final userController = Get.find<TeacherController>();
    if (isPresent.value) {
      userController.attendanceController!.present.add(studentId);
      userController.attendanceController!.absent.remove(studentId);
    } else {
      userController.attendanceController!.absent.add(studentId);
      userController.attendanceController!.present.remove(studentId);
    }
    print(userController.attendanceController!.present);
    print(userController.attendanceController!.absent);
  }
}
