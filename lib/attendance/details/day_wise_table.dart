import 'package:flutter/material.dart';
import 'package:gncms_clone/attendance/details/day_wise_display_widget.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../initial_data.dart';

class DayWiseTable {
  static TableRow buildRow(
      {required List<String> children, required DateTime date, isHeader}) {
    List<Widget> newTableChildren = [
      Center(
        child: Column(
          children: [
            Text(
              !isHeader
                  ? "${date.day}-${DateFormat('MMMM').format(date).substring(0, 3)}"
                  : 'Date',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (!isHeader)
              Text(
                DateFormat('EEEE').format(date).substring(0, 3),
                style: const TextStyle(color: Colors.grey),
              )
          ],
        ),
      ),
    ];
    for (var element in children) {
      newTableChildren.add(
        Padding(
          padding: isHeader ? const EdgeInsets.all(5) : const EdgeInsets.all(0),
          child: Center(
            child: isHeader
                ? Text(
                    element,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12),
                  )
                : TextDetailButton(
                    dateTime: date,
                    text: element,
                    subject: ' ',
                    presentAbsentPending: 'present',
                  ),
          ),
        ),
      );
    }
    TableRow newTableRow = TableRow(children: newTableChildren);
    return newTableRow;
  }

  static List<TableRow> tableContent() {
    List<TableRow> children = [];
    Timestamp timestampStart = InitialData
            .globalUserBatchDetails[InitialData.globalCurrentSem]['start'],
        timestampEnd = InitialData
            .globalUserBatchDetails[InitialData.globalCurrentSem]['end'];

    DateTime start =
        DateTime.fromMillisecondsSinceEpoch(timestampStart.seconds * 1000);
    DateTime end =
        DateTime.fromMillisecondsSinceEpoch(timestampEnd.seconds * 1000);
    int i = 0;
    while (start.isBefore(end) && i <= 20) {
      i++;
      children
          .add(buildRow(date: start, children: cells(start), isHeader: false));
      start = start.add(const Duration(days: 1));
    }
    return children;
  }

  static List<String> slots() {
    List<String> slots = [];

    for (var i = 0; i < 9; i++) {
      slots.add('Slot ${i + 1}');
    }
    return slots;
  }

  static List<TableRow> tableContentTest() {
    List<TableRow> children = [];
    int i = 0;
    while (i <= 20) {
      i++;
      children.add(buildRow(
          date: DateTime.now(),
          children: cells(DateTime.now()),
          isHeader: false));
    }
    return children;
  }

  static List<String> cells(DateTime currentDate) {
    List<String> cell = [];
    InitialData.globalUserAttendance[InitialData.globalCurrentSem]['subject'];
    InitialData.globalCurrentSubjects;

    for (var i = 0; i < 9; i++) {
      if (i % 2 == 0) {
        cell.add('P');
      } else {
        cell.add('A');
      }
    }
    return cell;
  }

  static Table tableData() {
    return Table(
      border: TableBorder.all(width: 0.1),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FractionColumnWidth(0.2),
      },
      children: [
        buildRow(
          date: DateTime.now(),
          children: slots(),
          isHeader: true,
        ),
        ...tableContentTest()
      ],
    );
  }
}
