import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gncms_clone/custom_widgets/attendance_detail_card.dart';
import 'package:gncms_clone/initial_data.dart';
import 'package:intl/intl.dart';

import '../../helper.dart';

class DayWiseDetails extends StatefulWidget {
  const DayWiseDetails({Key? key}) : super(key: key);

  static const id = '/attendance/details/day_wise';

  @override
  State<DayWiseDetails> createState() => _DayWiseDetailsState();
}

class _DayWiseDetailsState extends State<DayWiseDetails> {
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

  List<Widget> generateAttendanceDetailsCards() {
    //init

    List<Widget> children = [];
    print('hello');
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('P = Present,'),
              Text('A = Absent,'),
              Text('- = No Lecture/Lab,'),
              Text('PN = Pending'),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView(
              children: generateAttendanceDetailsCards(),
            ),
          ),
        ],
      ),
    );
  }
}
