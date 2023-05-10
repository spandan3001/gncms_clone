import 'package:flutter/material.dart';
import 'package:gncms_clone/initial_data.dart';
import 'package:provider/provider.dart';
import '../custom_widgets/attendance_card.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({Key? key}) : super(key: key);
  static const id = '/attendanceScreen';

  List<AttendanceCard> generateAttendanceCard() {
    var attendanceCards = InitialData.globalUserAttendance.keys.map((key) =>
        AttendanceCard(
            sem: key,
            batch: InitialData.globalUserAttendance[key]['batch'],
            totalPercentage: InitialData.globalUserAttendance[key]
                ['totalPercentage']));
    return attendanceCards.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Attendance'),
      ),
      body: Consumer<InitialData>(
        builder: (context, dataClass, child) => Column(
          children: generateAttendanceCard(),
        ),
      ),
    );
  }
}
