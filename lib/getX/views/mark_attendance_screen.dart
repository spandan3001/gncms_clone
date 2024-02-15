import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gncms_clone/getX/controllers/main_controller.dart';
import 'package:gncms_clone/getX/controllers/user_controllers/teacher/teacher_user_controller.dart';
import 'package:gncms_clone/getX/utils/common_widgets/app_bar.dart';

import '../controllers/user_controllers/teacher/atteandanceMarkController.dart';
import '../data/model/student_model.dart';

class MarkAttendanceScreen extends StatelessWidget {
  const MarkAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<TeacherController>();

    return Scaffold(
      appBar: customAppBar(
          title: "Mark Attendance",
          onPressed: () {
            userController.attendanceController!.present.clear();
            userController.attendanceController!.absent.clear();
            Get.back();
          }),
      body: ListView.builder(
        itemCount: userController.attendanceController!.students.length,
        itemBuilder: (context, index) {
          final studentModel =
              userController.attendanceController!.students[index];

          // Create a new instance of AttendanceController for each card
          final attendanceMarkController = AttendanceMarkController();

          return StudentAttendanceCard(
            studentModel: studentModel,
            attendanceMarkController: attendanceMarkController,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Map<String, dynamic> args = Get.arguments;
          final mainController = Get.find<MainController>();

          await mainController.firestoreController.addAttendance(
              args: args,
              present: userController.attendanceController!.present,
              absent: userController.attendanceController!.absent);

          await userController.attendanceController!
              .reloadAttendanceModelAndGoBack();
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}

class StudentAttendanceCard extends StatelessWidget {
  final StudentModel studentModel;
  final AttendanceMarkController
      attendanceMarkController; // Accept a unique controller for each card

  const StudentAttendanceCard({
    Key? key,
    required this.studentModel,
    required this.attendanceMarkController, // Receive unique controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(studentModel.usn),
        trailing: Obx(
          () => Checkbox(
            value: attendanceMarkController.isPresent.value,
            onChanged: (value) {
              attendanceMarkController.setPresentState(
                  value ?? false, studentModel.id);
            },
          ),
        ),
      ),
    );
  }
}
