// Import necessary packages
import 'package:get/get.dart';
import 'package:gncms_clone/getX/controllers/firestore_controller.dart';
import 'package:gncms_clone/getX/controllers/login_controller.dart';
import 'package:gncms_clone/getX/controllers/register_controller.dart';
import 'package:gncms_clone/getX/controllers/user_controllers/user_controller.dart';

import '../../constants.dart';
import '../data/model/student_model.dart';
import '../data/model/teacher_model.dart';
import '../data/repository/app_repository.dart';
import '../route/app_routes.dart';

class MainController extends GetxController {
  final AppRepository repository = AppRepository();
  final LoginController loginController = Get.put(LoginController());
  final RegisterController registerController = Get.put(RegisterController());
  final FirestoreController firestoreController =
      Get.put(FirestoreController());

  Rx<UserType> currentUser = UserType.none.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await init();
  }

  Future<void> init() async {
    try {
      await repository.init();
      // After initializing the repository, set the user controller
      setUserControllerFromPrefs();
    } catch (e) {
      // Handle initialization errors
      print('Error initializing repository: $e');
    }
  }

  void setUserControllerFromPrefs() async {
    try {
      final userModelMap = await repository.getCurrentUserModel();
      print(userModelMap);
      if (userModelMap == null || userModelMap.isEmpty) {
        Get.toNamed(AppRoutes.getLoginRoute());
      } else if (userModelMap['userType'] == UserType.student.name) {
        Get.toNamed(AppRoutes.getStudentHomeRoute());
        setUserController(
            StudentModel.fromJson(userModelMap), UserType.student);
      } else {
        Get.toNamed(AppRoutes.getTeacherHomeRoute());
        setUserController(
            TeacherModel.fromJson(userModelMap), UserType.teacher);
      }
    } catch (e) {
      // Handle errors retrieving user data
      print('Error retrieving user data: $e');
    }
  }

  void setUserController(dynamic userModel, UserType userType) {
    Get.put(UserController(userType: userType, userModel: userModel));
  }
}
