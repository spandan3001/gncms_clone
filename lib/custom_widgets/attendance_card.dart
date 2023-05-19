import 'package:flutter/material.dart';
import 'package:gncms_clone/attendance/details/day_wise_table.dart';

import '../attendance/details/details_screen.dart';
import '../initial_data.dart';

class AttendanceCard extends StatelessWidget {
  const AttendanceCard(
      {Key? key,
      required this.sem,
      required this.batch,
      required this.totalPercentage})
      : super(key: key);
  final String sem;
  final String batch;
  final double totalPercentage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 5.0,
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        type: MaterialType.card,
        child: InkWell(
          onTap: () {
            InitialData.globalCurrentSem = sem;
            InitialData.globalDayTableData = DayWiseTable.tableData();
            InitialData.globalDayTableHeader = DayWiseTable.tableHeader();
            NavigatorState state = Navigator.of(context);
            state.pushNamed(DetailsScreen.id);
          },
          child: SizedBox(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                                        sem,
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
                                  Text(
                                    batch,
                                    style: const TextStyle(
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
                            value: totalPercentage / 100,
                            minHeight: 5,
                            backgroundColor: const Color(0xFFEAFAF5),
                            valueColor:
                                const AlwaysStoppedAnimation(Color(0xFF07BD84)),
                          ),
                        ),
                      ),
                      Text(
                        '${totalPercentage.toString()}%',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
