import 'package:get/get.dart';
import 'package:gncms_clone/getX/data/model/teacher_model.dart';

class TeacherController extends GetxController {
  TeacherModel? _teacherModel;

  void setUser(TeacherModel teacherModel) {
    _teacherModel = teacherModel;
  }

  TeacherModel? getUser() {
    return _teacherModel;
  }

  TeacherController({required TeacherModel teacherModel})
      : _teacherModel = teacherModel;
}
