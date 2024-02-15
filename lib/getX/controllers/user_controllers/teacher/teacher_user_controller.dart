import 'package:get/get.dart';
import 'package:gncms_clone/getX/controllers/user_controllers/user_type_controller.dart';
import 'package:gncms_clone/getX/data/model/teacher_model.dart';
import '../../../route/app_routes.dart';
import 'attendance_controller.dart';

class TeacherController extends UserTypeController {
  TeacherModel? _teacherModel;
  TeacherAttendanceController? attendanceController;

  TeacherController({required TeacherModel teacherModel})
      : _teacherModel = teacherModel;

  void setUser(TeacherModel teacherModel) {
    _teacherModel = teacherModel;
  }

  Future<void> setAttendanceControllerAndGoScreen() async {
    attendanceController =
        TeacherAttendanceController(teacherModel: _teacherModel!);
    await attendanceController!.getListOfAttendanceModel();
    Get.toNamed(AppRoutes.getClassListScreen);
  }

  TeacherModel? getUser() {
    return _teacherModel;
  }

  @override
  void someCommonMethod() {
    // TODO: implement someCommonMethod
  }
}
