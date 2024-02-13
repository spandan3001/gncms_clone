import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gncms_clone/getX/controllers/user_controllers/teacher_user_controller.dart';

import '../data/model/student_model.dart';

class MarkAttendanceScreen extends StatelessWidget {
  const MarkAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = Get.find<TeacherController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mark Attendance'),
      ),
      body: ListView.builder(
        itemCount: userModel.students.length,
        itemBuilder: (context, index) {
          final studentModel = userModel.students[index];
          final studentName =
              "${studentModel.firstName} ${studentModel.lastName}";
          final studentID = studentModel.usn;
          return StudentAttendanceCard(
              studentName: studentName, studentID: studentID);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.save),
      ),
    );
  }
}

class StudentAttendanceCard extends StatefulWidget {
  final String studentName;
  final String studentID;

  const StudentAttendanceCard({
    Key? key,
    required this.studentName,
    required this.studentID,
  }) : super(key: key);

  @override
  _StudentAttendanceCardState createState() => _StudentAttendanceCardState();
}

class _StudentAttendanceCardState extends State<StudentAttendanceCard> {
  bool isPresent = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(widget.studentName),
        subtitle: Text(widget.studentID),
        trailing: Checkbox(
          value: isPresent,
          onChanged: (value) {
            setState(() {
              isPresent = value ?? false;
            });
          },
        ),
      ),
    );
  }
}
