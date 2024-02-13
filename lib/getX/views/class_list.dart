import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gncms_clone/getX/controllers/user_controllers/teacher_user_controller.dart';
import 'package:gncms_clone/getX/route/app_routes.dart';

import '../controllers/main_controller.dart';
import '../data/model/timetable_model.dart';

class ClassListScreen extends StatefulWidget {
  const ClassListScreen({super.key});

  @override
  State<ClassListScreen> createState() => _ClassListScreenState();
}

class _ClassListScreenState extends State<ClassListScreen> {
  final mainController = Get.find<MainController>();
  final userController = Get.find<TeacherController>();

  Map<String, List<TimetableModel>> semesterList = {};

  @override
  void initState() {
    super.initState();
    semesterList = userController.initAttendanceScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class List'),
      ),
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
              itemCount: semesterList.length,
              itemBuilder: (context, index) {
                final semesterData = semesterList.values.elementAt(index);
                return GestureDetector(
                  onTap: () {
                    // You can fetch sections based on selected semester if required
                    // For simplicity, let's navigate directly to sections
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SectionListScreen(semesterData: semesterData),
                      ),
                    );
                  },
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(semesterData.first.semester),
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

class SectionListScreen extends StatelessWidget {
  final List<TimetableModel> semesterData;

  const SectionListScreen({Key? key, required this.semesterData})
      : super(key: key);

  Map<String, TimetableModel> init() {
    Map<String, TimetableModel> sectionList = {};

    for (TimetableModel timetableModel in semesterData) {
      // Get semester, section, and branch
      String section = timetableModel.section;

      // Create or get the map for the semester
      sectionList[section] = timetableModel;
    }
    return sectionList;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, TimetableModel> sectionList = init();

    return Scaffold(
      appBar: AppBar(
        title: Text('Section List - ${semesterData.first.semester}'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Select Section',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: sectionList.length,
              itemBuilder: (context, index) {
                final sectionData = sectionList.values.elementAt(index);
                return GestureDetector(
                  onTap: () {
                    // You can fetch classes based on selected section if required
                    // For simplicity, let's navigate directly to class list
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClassListInSectionScreen(
                          timetableModel: sectionData,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(sectionData.section),
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
  final TimetableModel timetableModel;

  const ClassListInSectionScreen({
    Key? key,
    required this.timetableModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Class List - ${timetableModel.semester} (${timetableModel.section.toUpperCase()})'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Select Class',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: timetableModel.days.length,
              itemBuilder: (context, index) {
                final dayData = timetableModel.days[index];
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dayData.slots.length,
                  itemBuilder: (context, index) {
                    final classData = dayData.slots[index];
                    return GestureDetector(
                      onTap: () async {
                        final userController = Get.find<TeacherController>();
                        await userController.getStudents(
                            branch: timetableModel.branch,
                            semester: timetableModel.semester,
                            section: timetableModel.section);
                        Get.toNamed(AppRoutes.getMarkAttendanceScreen);
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ListTile(
                          title: Text(classData.class_),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(classData.time.toDate().day.toString()),
                                  const SizedBox(width: 2),
                                  Text(
                                      classData.time.toDate().month.toString()),
                                  const SizedBox(width: 2),
                                  Text(classData.time.toDate().year.toString()),
                                ],
                              ),
                              Text(classData.subject),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
