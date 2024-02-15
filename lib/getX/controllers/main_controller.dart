// Import necessary packages
import 'package:get/get.dart';
import 'package:gncms_clone/getX/controllers/firestore_controller.dart';
import 'package:gncms_clone/getX/controllers/login_controller.dart';
import 'package:gncms_clone/getX/controllers/register_controller.dart';
import 'package:gncms_clone/getX/controllers/user_controllers/student/student_user_controller.dart';
import 'package:gncms_clone/getX/controllers/user_controllers/teacher/teacher_user_controller.dart';

import '../../constants.dart';
import '../data/model/database_model.dart';
import '../data/model/student_model.dart';
import '../data/model/teacher_model.dart';
import '../data/repository/app_repository.dart';
import '../route/app_routes.dart';

class MainController extends GetxController {
  final AppRepository repository = AppRepository();
  final LoginController loginController = Get.put(LoginController());
  final RegisterController registerController = Get.put(RegisterController());
  late final DatabaseModel dataBaseModel;
  final FirestoreController firestoreController =
      Get.put(FirestoreController());
  dynamic userController;

  Rx<UserType> currentUser = UserType.student.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await init();
  }

  Future<void> init() async {
    try {
      await repository.init();
      // After initializing the repository, set the user controller
      setUserControllerFromLocalStorage();
    } catch (e) {
      // Handle initialization errors
      print('Error initializing repository: $e');
    }
  }

  void setUserControllerFromLocalStorage() async {
    try {
      final userModelMap = await repository.getCurrentUserModel();

      if (userModelMap == null || userModelMap.isEmpty) {
        Get.toNamed(AppRoutes.getLoginRoute);
      } else if (userModelMap['userType'] == UserType.student.name) {
        currentUser.value = UserType.student;
        setUserController(
            StudentModel.fromJson(userModelMap), UserType.student);

        Get.toNamed(AppRoutes.getStudentHomeRoute);
      } else {
        currentUser.value = UserType.teacher;

        setUserController(
            TeacherModel.fromJson(userModelMap), UserType.teacher);
        Get.toNamed(AppRoutes.getTeacherHomeRoute);
      }
    } catch (e) {
      // Handle errors retrieving user data
      print('Error retrieving user data: $e');
    }
  }

  void setUserController(dynamic userModel, UserType userType) {
    if (userType == UserType.student) {
      userController = Get.put(StudentController(studentModel: userModel));
    } else {
      userController = Get.put(TeacherController(teacherModel: userModel));
    }
  }
}
