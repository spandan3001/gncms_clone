import 'package:flutter/material.dart';

const kTimeStyle = TextStyle(
    fontSize: 12.0, color: Color(0xFF5E5D5D), fontWeight: FontWeight.bold);

const kLabColor = Color(0xFFF80202);
const kLabBackColor = Color(0x39F80202);

const kLectureColor = Color(0xFF02BDEC);
const kLectureBackColor = Color(0x3901DEFA);
Map details = {
  'absent': {
    'symbol': 'A',
    'textColor': Colors.red.shade50,
    'backgroundColor': Colors.red.shade100
  },
  'present': {
    'symbol': 'P',
    'textColor': Colors.green.shade50,
    'backgroundColor': Colors.green.shade100
  },
  'pending': {
    'symbol': 'PN',
    'textColor': Colors.yellow.shade50,
    'backgroundColor': Colors.yellow.shade100
  },
};
