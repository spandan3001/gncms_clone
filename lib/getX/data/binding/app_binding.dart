// Import necessary packages and files
import 'package:get/get.dart';
import '../../controllers/main_controller.dart';

// Define a bindings class for the home screen
class HomeBinding extends Bindings {
  // Override the dependencies method to specify dependencies
  @override
  Future<void> dependencies() async {
    // Use Get.putAsync to asynchronously initialize and put an instance of MainLogicController
    await Get.putAsync(() async => MainController(), permanent: true);
  }
}
