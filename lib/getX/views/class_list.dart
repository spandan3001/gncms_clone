import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gncms_clone/getX/controllers/user_controllers/teacher/attendance_controller.dart';
import 'package:gncms_clone/getX/controllers/user_controllers/teacher/teacher_user_controller.dart';
import 'package:gncms_clone/getX/data/model/attendance_model.dart';
import 'package:gncms_clone/getX/utils/common_widgets/app_bar.dart';
import '../controllers/main_controller.dart';

class ClassListScreen extends StatefulWidget {
  const ClassListScreen({super.key});

  @override
  State<ClassListScreen> createState() => _ClassListScreenState();
}

class _ClassListScreenState extends State<ClassListScreen> {
  final mainController = Get.find<MainController>();
  final userController = Get.find<TeacherController>();

  List<AttendanceModel> semesterSectionList = [];

  @override
  void initState() {
    super.initState();
    semesterSectionList =
        userController.attendanceController!.listOfAttendanceModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: 'Class List',
          onPressed: () {
            userController.attendanceController!.dispose();
            Get.back();
          }),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Select Semester',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: semesterSectionList.length,
              itemBuilder: (context, index) {
                var attendanceModel = semesterSectionList.elementAt(index);
                return GestureDetector(
                  onTap: () async {
                    await userController.attendanceController!
                        .goNextSecSemScreen(
                            section: attendanceModel.section,
                            semester: attendanceModel.semester);
                  },
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Row(
                        children: [
                          const Text("Semester:-"),
                          Text(attendanceModel.semester),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          const Text("Section:-"),
                          Text(attendanceModel.section.toUpperCase()),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ClassListInSectionScreen extends StatelessWidget {
  const ClassListInSectionScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<TeacherController>();
    final attendanceController = userController.attendanceController!;
    return Scaffold(
      appBar: customAppBar(
          title:
              'Class List - ${attendanceController.currentAttendanceModel!.value.semester} (${attendanceController.currentAttendanceModel!.value.section.toUpperCase()})',
          onPressed: () {
            userController.attendanceController!.currentAttendanceModel = null;
            Get.back();
          }),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Select Class',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: attendanceController
                      .currentAttendanceModel!.value.days.length,
                  itemBuilder: (context, index) {
                    final dayModel = attendanceController
                        .currentAttendanceModel!.value.days[index];
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dayModel.slots.length,
                      itemBuilder: (context, index) {
                        final slotModel = dayModel.slots[index];
                        return GestureDetector(
                          onTap: () {
                            final userController =
                                Get.find<TeacherController>();
                            userController.attendanceController!
                                .goToMarkAttendanceScreen(
                                    attendanceController
                                        .currentAttendanceModel!.value,
                                    dayModel.id,
                                    slotModel.id);
                          },
                          child: Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: ListTile(
                              title: Text(slotModel.class_),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      const Text("Date:-"),
                                      const SizedBox(width: 2),
                                      Text(slotModel.time.day.toString()),
                                      const SizedBox(width: 2),
                                      Text(slotModel.time.month.toString()),
                                      const SizedBox(width: 2),
                                      Text(slotModel.time.year.toString()),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text("Time:-"),
                                      const SizedBox(width: 2),
                                      Text(slotModel.time.hour.toString()),
                                      const SizedBox(width: 2),
                                      const Text(":"),
                                      const SizedBox(width: 2),
                                      Text(slotModel.time.minute.toString()),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(slotModel.subject),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
