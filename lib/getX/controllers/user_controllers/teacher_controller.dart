import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:gncms_clone/getX/controllers/user_controllers/user_type_controller.dart';

import '../../data/model/teacher_model.dart';

class TeacherController extends GetxController implements UserTypeController {
  late final TeacherModel teacherModel;

  TeacherController({required this.teacherModel});

  @override
  void someCommonMethod() {
    print('Teacher-specific implementation of someCommonMethod');
  }
}
