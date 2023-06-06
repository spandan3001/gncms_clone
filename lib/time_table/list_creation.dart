import 'dart:async';

import 'package:gncms_clone/initial_data.dart';
import 'package:gncms_clone/time_table/body_page.dart';
import 'package:gncms_clone/custom_widgets/t_card.dart';
import 'package:flutter/material.dart';

Map<String, String> objSubjectTeacher = {};

String subject = '', teacherName = '';

class ListCreation {
  var dayIndex = 5;
  var timeIndexForPeriod = 5;
  var time = DateTime.now();
  int iTimeIndexForPeriod = 0;
  int iDayIndex = 0;

  void startCountdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      checkTimeSlot();
    });
  }

  bool isInSlot(int hour1, int minute1, int hour2, int minute2) {
    time = DateTime.now();
    DateTime slot1 = DateTime(time.year, time.month, time.day, hour1, minute1);
    DateTime slot2 = DateTime(time.year, time.month, time.day, hour2, minute2);
    return (time.isAfter(slot1) && time.isAfter(slot2));
  }

  void checkTimeSlot() {
    if (isInSlot(9, 0, 9, 55)) {
      timeIndexForPeriod = 0;
    } else if (isInSlot(9, 55, 10, 50)) {
      timeIndexForPeriod = 1;
    } else if (isInSlot(11, 0, 11, 55)) {
      timeIndexForPeriod = 2;
    } else if (isInSlot(11, 55, 12, 55)) {
      timeIndexForPeriod = 3;
    } else if (isInSlot(1, 35, 4, 20)) {
      timeIndexForPeriod = 4;
    } else {
      timeIndexForPeriod = 5;
    }

    //print(timeIndexForPeriod);
  }

  Map<String, Widget> createCardWidget() {
    Map<String, Widget> listOfCards = {
      'monday': const SizedBox(),
      'tuesday': const SizedBox(),
      'wednesday': const SizedBox(),
      'thursday': const SizedBox(),
      'friday': const SizedBox(),
      'saturday': const SizedBox(),
    };
    List<Widget> cards = [];

    dayIndex = DateTime.now().weekday - 1;
    globalObj.getCurrentTimeTable();

    //print(InitialData.globalCurrentTimeTable);
    Map<String, dynamic> temp;
    InitialData.globalCurrentTimeTable.forEach((day, slots) {
      temp = slots;
      iDayIndex++;
      // to sort

      List<MapEntry<String, dynamic>> sortedEntries = temp.entries.toList()
        ..sort((a, b) => a.key.compareTo(b.key));

      temp = Map.fromEntries(sortedEntries);
      cards = [];
      iTimeIndexForPeriod = 0;
      temp.forEach((slot, value) {
        iTimeIndexForPeriod++;
        cards.add(TCardWidget(
            time: value['time'],
            typeText: 'Lecture',
            subject: value['subject'],
            teacherName: value['teacher'],
            isActive: (timeIndexForPeriod == iTimeIndexForPeriod &&
                    dayIndex == iDayIndex)
                ? true
                : false));
      });
      listOfCards[day] = BodyPage(cardWidget: cards);
    });
    return listOfCards;
  }
}
