import 'package:get/get.dart';
import 'package:gncms_clone/getX/controllers/student_user_controller.dart';
import 'package:gncms_clone/getX/controllers/teacher_user_controller.dart';

import '../../constants.dart';
import 'main_controller.dart';

class UserController extends GetxController {
  final UserType userType;
  final dynamic userModel;
  late final dynamic userController;

  final MainController mainController = Get.find();

  UserController({required this.userType, required this.userModel});

  @override
  void onInit() {
    super.onInit();
    if (userType == UserType.student) {
      userController = Get.put(StudentController(studentModel: userModel));
    } else if (userType == UserType.teacher) {
      userController = Get.put(TeacherController(teacherModel: userModel));
    } else {
      userController = null;
    }
  }

  void setUserModel() {
    //TODO:complete the setUserModel and also check weather code is efficient;
  }
}
