import 'dart:async';

import 'package:gncms_clone/time_table/body_page.dart';
import 'package:gncms_clone/time_table/t_card.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

List<Widget> cards = [];

Map<String, String> objSubjectTeacher = {};

String subject = '', teacherName = '';

List<Widget> listOfCards = [];

class ListCreation {
  final List<List<String>> _timeTable = [
    ['61', '63', '643', '652', 'l67'],
    ['62', '61', '63', '652', 'web'],
    ['62', '643', '63', '652', '0'],
    ['63', '643', '62', '652', 'l66'],
    ['61', '61', '62', '0', 'mp68'],
  ];

  var dayIndex = 5;
  var timeIndexForPeriod = 5;
  var time = DateTime.now();

  void startCountdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      checkTimeSlot();
    });
  }

  void checkTimeSlot() {
    time = DateTime.now();
    if (time.hour == 9 && (time.minute >= 0 && time.minute <= 55)) {
      timeIndexForPeriod = 0;
    } else if ((time.hour == 9 && (time.minute > 55 && time.minute <= 59)) ||
        (time.hour == 10 && (time.minute >= 0 && time.minute <= 50))) {
      timeIndexForPeriod = 1;
    } else if ((time.hour == 11) && (time.minute >= 0 && time.minute <= 55)) {
      timeIndexForPeriod = 2;
    } else if ((time.hour == 11 && (time.minute > 55 && time.minute <= 59)) ||
        (time.hour == 12 && (time.minute >= 0 && time.minute <= 50))) {
      timeIndexForPeriod = 3;
    } else if ((time.hour == 13 && (time.minute >= 35 && time.minute <= 59)) ||
        (time.hour == 16 && (time.minute >= 0 && time.minute <= 20))) {
      timeIndexForPeriod = 4;
    } else {
      timeIndexForPeriod = 5;
    }

    //print(timeIndexForPeriod);
  }

  void createCardWidget() {
    dayIndex = DateTime.now().weekday - 1;
    for (var day in _timeTable) {
      cards = [];
      for (var i = 0; i < day.length; i++) {
        objSubjectTeacher = kSubjects[day[i]]!;
        subject = objSubjectTeacher['subject']!;
        teacherName = objSubjectTeacher['teacher']!;

        cards.add(
          TCardWidget(
              time: kTime[i],
              typeText: i == 4 ? 'Lab' : 'Lecture',
              subject: subject,
              teacherName: teacherName,
              isActive: i == timeIndexForPeriod &&
                  _timeTable.indexOf(day) == dayIndex),
        );
      }

      listOfCards.add(BodyPage(cardWidget: cards));
    }
  }

  List<Widget> getCardWidget() {
    listOfCards = [];
    createCardWidget();
    return listOfCards;
  }
}
