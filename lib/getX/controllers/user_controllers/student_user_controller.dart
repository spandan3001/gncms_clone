import 'package:get/get.dart';
import 'package:gncms_clone/getX/controllers/main_controller.dart';
import 'package:gncms_clone/getX/controllers/user_controllers/user_type_controller.dart';
import 'package:gncms_clone/getX/data/model/student_model.dart';

import '../../data/model/attendance_model.dart';

class StudentController extends UserTypeController {
  StudentModel _studentModel;
  List<AttendanceSlotModel>? attendanceModels;

  Future<List<AttendanceSlotModel>?> getAttendance() async {
    final mainController = Get.find<MainController>();
    return await mainController.firestoreController
        .getAttendance(_studentModel);
  }

  @override
  void onInit() async {
    super.onInit();
    attendanceModels = await getAttendance();
  }

  StudentController({required StudentModel studentModel})
      : _studentModel = studentModel;

  void setUser(StudentModel studentModel) {
    _studentModel = studentModel;
  }

  StudentModel getUser() {
    return _studentModel;
  }

  @override
  void someCommonMethod() {
    // TODO: implement someCommonMethod
  }
}
