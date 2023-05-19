import 'package:flutter/material.dart';
import 'package:gncms_clone/initial_data.dart';
import 'package:provider/provider.dart';
import '../custom_widgets/attendance_card.dart';

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

  List<AttendanceCard> generateAttendanceCard() {
    var attendanceCards = InitialData.globalUserAttendance.keys.map((sem) =>
        AttendanceCard(sem: sem, batch: getBatch(sem), totalPercentage: 100.0));
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
