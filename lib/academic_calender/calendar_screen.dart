import 'package:flutter/material.dart';
import 'package:gncms_clone/academic_calender/complex_calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeCalendarScreen extends StatefulWidget {
  const HomeCalendarScreen({super.key});

  static const id = '/HomeCalenderScreen';

  @override
  HomeCalendarScreenState createState() => HomeCalendarScreenState();
}

class HomeCalendarScreenState extends State<HomeCalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Calendar Example'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  // Call `setState()` when updating calendar format
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                // No need to call `setState()` here
                _focusedDay = focusedDay;
              },
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, TableComplexExample.id);
                  },
                  child: const Text("Go To complex button")),
            )
          ],
        ),
      ),
    );
  }
}
