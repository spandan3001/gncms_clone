import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gncms_clone/getX/controllers/user_controllers/student/student_user_controller.dart';
import 'package:gncms_clone/getX/data/model/student_attendance_model.dart';
import 'package:gncms_clone/initial_data.dart';

import '../../getX/utils/common_widgets/attendance_data_row.dart';

class SubjectWiseDetails extends StatelessWidget {
  const SubjectWiseDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<StudentController>();
    final studentModel = userController.getUser();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 20.0,
                width: 50.0,
                color: Colors.black,
                child: Center(
                  child: Text(
                    studentModel.semester,
                    style: const TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'A.Y. ',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                InitialData.globalCurrentBatch,
                style: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const AttendanceTable(),
        ],
      ),
    );
  }
}

class AttendanceTable extends StatelessWidget {
  const AttendanceTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<StudentController>();
    final studentAttendanceModel =
        userController.attendanceController!.currentStudentAttendanceModel;
    return Expanded(
      child: ListView.builder(
          itemCount: studentAttendanceModel!.listOfSemesterAttendance.length,
          itemBuilder: (context, index) {
            final entry =
                studentAttendanceModel!.listOfSemesterAttendance[index];
            return AttendanceDataRow(
              class_: entry.class_,
              total: int.parse(entry.absent) + int.parse(entry.present),
              present: int.parse(entry.present),
              subject: entry.subject,
            );
          }),
    );
  }
}
