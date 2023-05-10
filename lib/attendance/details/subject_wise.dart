import 'package:flutter/material.dart';
import 'package:gncms_clone/initial_data.dart';

class SubjectWiseDetails extends StatelessWidget {
  const SubjectWiseDetails({Key? key}) : super(key: key);

  static const id = '/attendance/details/subject_wise';

  TableRow buildRow({required List<String> children, attendance, isHeader}) =>
      TableRow(
        decoration: isHeader
            ? const BoxDecoration(color: Colors.black12)
            : const BoxDecoration(),
        children: [
          ...children
              .map(
                (cell) => Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    cell,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              )
              .toList(),
          if (!isHeader)
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: Text(
                  '${attendance.toString()}%',
                  style: TextStyle(
                      color: attendance < 75 ? Colors.red : Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      );
  List<TableRow> tableContent() {
    List<TableRow> children = [];
    Map<String, dynamic> subjects =
        InitialData.globalCurrentSubjects[InitialData.globalCurrentSem];
    List<String> temp;
    print(subjects);
    InitialData.globalUserAttendance[InitialData.globalCurrentSem]
        .forEach((key, value) {
      temp = [];
      if (key != 'batch' && key != 'totalPercentage') {
        temp.add(subjects[key]);
        temp.add(value['total'].toString());
        temp.add(value['present'].toString());
        children.add(buildRow(
            children: temp, attendance: value['percentage'], isHeader: false));
      }
    });
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 20.0,
                width: 50.0,
                color: Colors.black,
                child: Center(
                  child: Text(
                    InitialData.globalCurrentSem,
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
                'A.Y. ',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                InitialData.globalCurrentBatch,
                style: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Table(
            border: TableBorder.all(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FractionColumnWidth(0.5),
              1: FractionColumnWidth(0.15),
              2: FractionColumnWidth(0.15),
            },
            children: [
              buildRow(
                  children: ['Course', 'Total', 'Present', 'Attendance'],
                  isHeader: true),
              ...tableContent()
            ],
          )
        ],
      ),
    );
  }
}
