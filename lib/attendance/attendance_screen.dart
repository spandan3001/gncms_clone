import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gncms_clone/getX/controllers/user_controllers/student_user_controller.dart';
import 'package:gncms_clone/getX/values/app_colors.dart';
import 'package:gncms_clone/initial_data.dart';
import '../getX/utils/common_widgets/attendance_card.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({Key? key}) : super(key: key);
  static const id = '/attendanceScreen';

  String getBatch(String sem) {
    int semInt = int.parse(sem[sem.length - 1]);
    int batchInt = int.parse(InitialData.globalCurrentBatch.substring(0, 4));
    if (semInt <= 2) {
      return "$batchInt-${batchInt + 1}";
    } else if (semInt <= 4) {
      return "${batchInt + 1}-${batchInt + 2}";
    } else if (semInt <= 6) {
      return "${batchInt + 2}-${batchInt + 3}";
    } else {
      return "${batchInt + 3}-${batchInt + 4}";
    }
  }

  List<AttendanceCard>? generateAttendanceCard() {
    final studentController = Get.find<StudentController>();
    final studentModel = studentController.getUser();
    final attendanceCards = studentController.attendanceModels?.map((sem) =>
        AttendanceCard(
            semester: studentModel.semester,
            batch: "2024",
            totalPercentage: 30.0));
    return attendanceCards?.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.keyboard_return,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.darkestBlue,
        title: const Text(
          'Attendance',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: generateAttendanceCard() ?? [],
      ),
    );
  }
}
