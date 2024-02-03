// Import necessary packages
import 'package:get/get.dart';
import 'package:gncms_clone/getX/controllers/login_controller.dart';
import 'package:gncms_clone/getX/controllers/register_controller.dart';
import 'package:gncms_clone/getX/controllers/user_controller.dart';

import '../../constants.dart';
import '../data/repository/app_repository.dart';

// Define the main logic controller
class MainController extends GetxController {
  // Declare controllers for each widget
  // late final Widget1Controller widget1Controller;

  //Instantiate the app repository

  final AppRepository repository = AppRepository();
  final LoginController loginController = Get.put(LoginController());
  final RegisterController registerController = Get.put(RegisterController());
  late final UserController userController;

  // Declare observable variables for success score, failure score, and total attempts
  Rx<UserType> currentUser = UserType.none.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await init();
  }

  Future<void> init() async {
    await repository.init();
  }

  void setUserController(dynamic userModel, UserType userType) {
    userController = UserController(userType: userType, userModel: userModel);
  }
}
