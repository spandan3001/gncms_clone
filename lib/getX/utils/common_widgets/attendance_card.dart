import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gncms_clone/getX/controllers/user_controllers/student/student_user_controller.dart';
import 'package:gncms_clone/getX/data/model/student_attendance_model.dart';
import 'package:gncms_clone/getX/route/app_routes.dart';

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({Key? key, required this.studentAttendanceModel})
      : super(key: key);
  final StudentAttendanceModel studentAttendanceModel;

  double generateTotalPercentage(
      List<SemesterAttendanceModel> semesterAttendance) {
    double total = 0.0;
    double present = 0.0;
    for (var ele in semesterAttendance) {
      present += double.parse(ele.present);
      total += double.parse(ele.present) + double.parse(ele.absent);
      print("yes");
    }
    return total == 0.0 ? 0.0 : present / total;
  }

  @override
  Widget build(BuildContext context) {
    final totalPercentage = generateTotalPercentage(
        studentAttendanceModel.listOfSemesterAttendance);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 5.0,
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        type: MaterialType.card,
        child: InkWell(
          onTap: () async {
            final userController = Get.find<StudentController>();
            userController.attendanceController!
                .setCurrentStudentAttendanceModel(studentAttendanceModel);
            Get.toNamed(AppRoutes.getAttendanceDetailScreen);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 20.0,
                                  width: 50.0,
                                  color: Colors.black,
                                  child: Center(
                                    child: Text(
                                      studentAttendanceModel.semester,
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
                                  'A.Y.  ',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  '2024',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const Text(
                              'Attendance',
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: LinearProgressIndicator(
                          value: totalPercentage,
                          minHeight: 5,
                          backgroundColor: const Color(0xFFEAFAF5),
                          valueColor: AlwaysStoppedAnimation(
                              totalPercentage < 0.75
                                  ? Colors.red
                                  : Colors.green),
                        ),
                      ),
                    ),
                    Text(
                      "${(totalPercentage * 100).toInt()}%",
                      style: TextStyle(
                          color: totalPercentage < 0.75
                              ? Colors.red
                              : Colors.green),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
