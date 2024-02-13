import 'package:flutter/material.dart';

class AttendanceDataRow extends StatelessWidget {
  final String course;
  final String subject;
  final int total;
  final int present;

  const AttendanceDataRow({
    Key? key,
    required this.course,
    required this.subject,
    required this.total,
    required this.present,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double attendancePercentage = total != 0 ? (present / total) : 0.0;
    return Expanded(
      child: Material(
        elevation: 5.0,
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        type: MaterialType.card,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Course: $course',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Subject: $subject',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total: $total'),
                  Text('Present: $present'),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: attendancePercentage,
                      minHeight: 5,
                      backgroundColor: const Color(0xFFEAFAF5),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF07BD84)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "${(attendancePercentage * 100).toInt()}%",
                    style: TextStyle(
                        color: attendancePercentage < 0.75
                            ? Colors.red
                            : Colors.green),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
