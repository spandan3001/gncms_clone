import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gncms_clone/getX/controllers/user_controllers/student/student_user_controller.dart';
import 'package:gncms_clone/getX/utils/common_widgets/app_bar.dart';
import '../getX/data/model/student_attendance_model.dart';
import '../getX/utils/common_widgets/attendance_card.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({Key? key}) : super(key: key);
  static const id = '/attendanceScreen';

  List<AttendanceCard> generateAttendanceCard() {
    final userController = Get.find<StudentController>();
    return userController.attendanceController!.listOfStudentAttendance
        .map((studentAttendance) =>
            AttendanceCard(studentAttendanceModel: studentAttendance))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final studentController = Get.find<StudentController>();
    final studentModel = studentController.getUser();
    List<AttendanceCard> body = generateAttendanceCard();
    return Scaffold(
      appBar: customAppBar(
        onPressed: () {
          Get.back();
        },
        title: 'Attendance',
      ),
      body: ListView.builder(
          itemCount: body.length,
          itemBuilder: (context, index) {
            return body[index];
          }),
    );
  }
}
