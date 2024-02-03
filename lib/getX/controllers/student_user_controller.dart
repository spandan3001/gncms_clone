import 'package:get/get.dart';
import 'package:gncms_clone/getX/data/model/student_model.dart';

class StudentController extends GetxController {
  StudentModel _studentModel;

  void setUser(StudentModel studentModel) {
    _studentModel = studentModel;
  }

  StudentModel getUser() {
    return _studentModel;
  }

  StudentController({required StudentModel studentModel})
      : _studentModel = studentModel;
}
