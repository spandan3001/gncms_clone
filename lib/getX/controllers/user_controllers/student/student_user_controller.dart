import 'package:get/get.dart';
import 'package:gncms_clone/getX/controllers/main_controller.dart';
import 'package:gncms_clone/getX/controllers/user_controllers/student/student_attendance_controller.dart';
import 'package:gncms_clone/getX/controllers/user_controllers/user_type_controller.dart';
import 'package:gncms_clone/getX/data/model/student_model.dart';

import '../../../data/model/attendance_model.dart';
import '../../../data/model/timetable_model.dart';

class StudentController extends UserTypeController {
  StudentModel _studentModel;
  StudentAttendanceController? attendanceController;
  TimetableModel? timetableModel;

  StudentController({required StudentModel studentModel})
      : _studentModel = studentModel;

  void setUser(StudentModel studentModel) {
    _studentModel = studentModel;
  }

  Future<void> setAttendanceController() async {
    attendanceController =
        StudentAttendanceController(studentModel: _studentModel);
  }

  StudentModel getUser() {
    return _studentModel;
  }

  @override
  void someCommonMethod() {
    // TODO: implement someCommonMethod
  }
}
