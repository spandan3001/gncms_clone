import 'package:get/get.dart';
import 'package:gncms_clone/getX/controllers/user_controllers/user_type_controller.dart';

import '../../data/model/student_model.dart';

class StudentController extends GetxController implements UserTypeController {
  late final StudentModel studentModel;

  StudentController({required this.studentModel});

  @override
  void someCommonMethod() {
    print('Student-specific implementation of someCommonMethod');
  }
}
