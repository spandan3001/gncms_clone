import 'package:get/get.dart';
import 'package:gncms_clone/getX/controllers/student_user_controller.dart';
import 'package:gncms_clone/getX/controllers/teacher_user_controller.dart';
import 'package:gncms_clone/getX/controllers/user_controllers/user_type_controller.dart';

import '../../../constants.dart';
import '../main_controller.dart';

class UserController extends GetxController {
  final UserType userType;
  late final UserTypeController userController;
  dynamic userModel;

  final MainController _mainController = Get.find();

  UserController({required this.userType, required this.userModel}) {
    initializeUserController();
  }

  void initializeUserController() {
    if (userType == UserType.student) {
      userController = Get.put(
          StudentController(studentModel: userModel) as UserTypeController);
    } else if (userType == UserType.teacher) {
      userController = Get.put(
          TeacherController(teacherModel: userModel) as UserTypeController);
    } else {
      throw Exception(
          "Invalid user type"); // Handle the default case appropriately
    }
  }

  void setUserModel(dynamic userModel) {
    this.userModel = userModel;
    // TODO: Complete the setUserModel logic
  }

  dynamic getUserModel() {
    if (userModel == null) {
      throw Exception("User model is not set yet.");
    }
    return userModel;
  }
}
