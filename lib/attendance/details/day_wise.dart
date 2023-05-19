import 'package:flutter/material.dart';
import 'package:gncms_clone/initial_data.dart';

class DayWiseDetails extends StatelessWidget {
  const DayWiseDetails({Key? key}) : super(key: key);

  static const id = '/attendance/details/day_wise';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
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
            InitialData.globalDayTableHeader,
            InitialData.globalDayTableData
          ],
        ),
      ),
    );
  }
}
