import 'package:flutter/material.dart';

class AttendanceTable extends StatelessWidget {
  final List<Map<String, dynamic>>
      data; // List of maps containing attendance data

  const AttendanceTable({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 40,
      border: TableBorder.all(),
      columns: const [
        DataColumn(label: Text('Course')),
        DataColumn(label: Text('Total')),
        DataColumn(label: Text('Present')),
        DataColumn(label: Text('Attendance')),
      ],
      rows: data.map((entry) {
        return DataRow(cells: [
          DataCell(Text(entry['course'])),
          DataCell(Text(entry['total'].toString())),
          DataCell(Text(entry['present'].toString())),
          DataCell(Text(_calculateAttendance(entry['total'], entry['present'])))
        ]);
      }).toList(),
    );
  }

  String _calculateAttendance(int total, int present) {
    if (total == 0) {
      return 'N/A';
    }
    double attendancePercentage = (present / total) * 100;
    return '${attendancePercentage.toStringAsFixed(2)}%';
  }
}
