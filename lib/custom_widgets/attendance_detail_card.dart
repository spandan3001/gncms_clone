import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../attendance/details/day_wise_pop-down.dart';
import '../initial_data.dart';

class AttendanceDayDetailCard extends StatelessWidget {
  final DateTime date;
  final String currentDay;
  final Map<String, dynamic> currentDayOfTimeTable;
  final int dayNumber;
  final Map<String, String> currentDaySlotDetails;
  final Map<String, dynamic> currentDayAttendanceDetail;

  List generateData() {
    List children = [];
    Map<String, dynamic> subjects =
        InitialData.globalCurrentSubjects[InitialData.globalSelectedSem];

    var localCurrentDayOfTimeTable = currentDayOfTimeTable;
    List<MapEntry<String, dynamic>> listData =
        currentDayOfTimeTable.entries.toList();

    listData.sort((a, b) => a.key.compareTo(b.key));

    localCurrentDayOfTimeTable = Map.fromEntries(listData);
    localCurrentDayOfTimeTable.forEach((slot, value) {
      children.add(Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(slot),
          // TextDetailButton(
          //   timeSlot: value['time'],
          //   teacherName: value['teacher'],
          //   dateTime: date,
          //   //fetched from the constant file
          //   slotDetailKey: currentDaySlotDetails[value['subject']]!,
          //   subject: subjects[value['subject']],
          // ),
        ],
      ));
    });

    return children;
  }

  const AttendanceDayDetailCard({
    Key? key,
    required this.date,
    required this.currentDay,
    required this.currentDayOfTimeTable,
    required this.currentDayAttendanceDetail,
    required this.dayNumber,
    required this.currentDaySlotDetails,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shadowColor: Theme.of(context).colorScheme.shadow,
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      elevation: 5.0,
      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      type: MaterialType.card,
      child: SizedBox(
          height: 80,
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${date.day}-${DateFormat('MMMM').format(date).substring(0, 3)}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat('EEEE').format(date).substring(0, 3),
                          style: const TextStyle(color: Colors.grey),
                        )
                      ]),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: VerticalDivider(
                    color: Colors.black,
                    width: 20.0,
                    thickness: 2,
                  ),
                ),
                Expanded(
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: [],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
