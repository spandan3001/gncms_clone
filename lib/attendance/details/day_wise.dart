import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gncms_clone/custom_widgets/attendance_detail_card.dart';
import 'package:gncms_clone/getX/controllers/user_controllers/student_user_controller.dart';
import 'package:gncms_clone/initial_data.dart';
import 'package:intl/intl.dart';

import '../../helper.dart';

class DayWiseDetails extends StatefulWidget {
  const DayWiseDetails({Key? key}) : super(key: key);

  @override
  State<DayWiseDetails> createState() => _DayWiseDetailsState();
}

class _DayWiseDetailsState extends State<DayWiseDetails> {
  final userController = Get.find<StudentController>();
  bool getSelectedAttendance(dayNumberInString) {
    if (InitialData.globalSelectedAttendance[dayNumberInString] != null) {
      InitialData.globalSelectedAttendance[dayNumberInString];
      return true;
    }
    return false;
  }

  Map<String, String> checkAttendance(dayNumberInString) {
    Map<String, String> attendanceOfSlot = {};
    if (InitialData.globalSelectedAttendance[dayNumberInString] != null) {
      InitialData.globalSelectedAttendance[dayNumberInString]['subject']
          .forEach((key, value) {
        List<dynamic> listOfStudent = value;
        var presentOrAbsent =
            Helpers.findById(listOfStudent, InitialData.globalUserId);
        if (listOfStudent.isNotEmpty) {
          if (presentOrAbsent == null) {
            attendanceOfSlot[key] = 'absent';
          } else {
            attendanceOfSlot[key] = 'present';
          }
        } else {
          attendanceOfSlot[key] = 'pending';
        }
      });
      //print(attendanceOfSlot);
    }
    return attendanceOfSlot;
  }

  bool nullCheckForGeneration() {
    return InitialData.globalSelectedAttendance.isNotEmpty;
  }

  List<Widget> generateAttendanceDetailsCards() {
    if (nullCheckForGeneration()) {
      List<Widget> children = [];
      Timestamp timestampStart = InitialData
              .globalUserBatchDetails[InitialData.globalSelectedSem]['start'],
          timestampEnd = InitialData
              .globalUserBatchDetails[InitialData.globalSelectedSem]['end'];
      DateTime start =
          DateTime.fromMillisecondsSinceEpoch(timestampStart.seconds * 1000);
      DateTime end =
          DateTime.fromMillisecondsSinceEpoch(timestampEnd.seconds * 1000);
      DateTime current = DateTime.now();
      int dayNumber = 1;
      while (start.isBefore(end) && start.isBefore(current)) {
        String currentDay = DateFormat('EEEE').format(start).toLowerCase();
        if (InitialData.globalCurrentTimeTable[currentDay] != null) {
          Map<String, dynamic> currentTimeTable =
              InitialData.globalCurrentTimeTable[currentDay];
          if (currentTimeTable.isNotEmpty) {
            children.add(Padding(
              padding: const EdgeInsets.all(2),
              child: AttendanceDayDetailCard(
                date: start,
                currentDay: currentDay,
                currentDayOfTimeTable:
                    InitialData.globalCurrentTimeTable[currentDay],
                currentDayAttendanceDetail:
                    getSelectedAttendance(dayNumber.toString())
                        ? InitialData
                            .globalSelectedAttendance[dayNumber.toString()]
                        : {},
                dayNumber: dayNumber,
                currentDaySlotDetails: checkAttendance(dayNumber.toString()),
              ),
            ));
            dayNumber++;
          }
        }
        start = start.add(const Duration(days: 1));
      }
      return children;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('P = Present,'),
              Text('A = Absent,'),
              Text('- = No Lecture/Lab,'),
              Text('PN = Pending'),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          //if null this
          if (userController.attendanceModels == null)
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'NO DATA',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.grey),
                  )
                ],
              ),
            ),
          if (userController.attendanceModels != null)
            for (var entry in userController.attendanceModels!)
              AttendanceDayDetailCard(
                date: entry.time.toDate(),
                dayNumber: 1,
                currentDay: '',
                currentDayOfTimeTable: {},
                currentDayAttendanceDetail: {},
                currentDaySlotDetails: {},
              ),
        ],
      ),
    );
  }
}
