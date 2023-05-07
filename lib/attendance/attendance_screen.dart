import 'package:flutter/material.dart';
import '../custom_widgets/attendance_card.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({Key? key}) : super(key: key);
  static const id = '/attendanceScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Attendance'),
      ),
      body: Column(
        children: const [
          AttendanceCard(),
          AttendanceCard(),
        ],
      ),
    );
  }
}
