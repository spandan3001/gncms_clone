import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gncms_clone/getX/controllers/user_controllers/student_user_controller.dart';
import 'package:gncms_clone/initial_data.dart';

import '../../getX/data/model/attendance_model.dart';
import '../../getX/utils/common_widgets/attendance_data_row.dart';

class SubjectWiseDetails extends StatelessWidget {
  const SubjectWiseDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<StudentController>();
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
                    userController.getUser().semester,
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
          AttendanceTable(attendanceModels: userController.attendanceModels)
        ],
      ),
    );
  }
}

class AttendanceTable extends StatelessWidget {
  final List<AttendanceSlotModel>? attendanceModels;

  const AttendanceTable({
    Key? key,
    required this.attendanceModels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (attendanceModels != null)
          for (var entry in attendanceModels!)
            AttendanceDataRow(
              course: entry.class_,
              total: entry.absent.length + entry.present.length,
              present: entry.present.length,
              subject: entry.subject,
            ),
      ],
    );
  }
}
