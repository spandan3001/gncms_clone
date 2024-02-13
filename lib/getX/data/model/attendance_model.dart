import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  AttendanceModel(
      {required this.days,
      required this.branch,
      required this.startTime,
      required this.endTime,
      required this.section,
      required this.semester,
      required this.id});
  final List<AttendanceDayModel> days;
  final String branch;
  final String section;
  final String semester;
  final Timestamp startTime;
  final Timestamp endTime;
  final String id;

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
        days: json['attendanceList'],
        branch: json['branch'],
        section: json['section'],
        semester: json['semester'],
        id: json['id'],
        startTime: json['startTime'],
        endTime: json['endTime']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'branch': branch,
      'section': section,
      'semester': semester,
      'startTime': startTime,
      'endTime': endTime,
      //'attendanceList': attendanceList
    };
  }
}

class AttendanceDayModel {
  final String id;
  final Timestamp time;
  final List<AttendanceSlotModel> slots;

  AttendanceDayModel({
    required this.id,
    required this.slots,
    required this.time,
  });

  factory AttendanceDayModel.fromFirestore(Map<String, dynamic> data) {
    return AttendanceDayModel(
      id: data['id'] ?? "",
      time: data['time'],
      slots: data['slots'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'time': time,
    };
  }
}

class AttendanceSlotModel {
  AttendanceSlotModel(
      {required this.present,
      required this.class_,
      required this.subject,
      required this.tdId,
      required this.time,
      required this.absent,
      required this.marked,
      required this.id});

  String id;
  final List<dynamic> present;
  final List<dynamic> absent;
  final String class_;
  final String tdId;
  final Timestamp time;
  final String subject;
  final bool marked;
  factory AttendanceSlotModel.fromJson(Map<String, dynamic> json) {
    return AttendanceSlotModel(
      absent: json['absent'],
      id: json['id'],
      present: json['present'],
      class_: json['class'],
      time: json['time'],
      marked: json['marked'],
      subject: json['subject'],
      tdId: json['tdId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'absent': absent,
      'present': present,
      'class': class_,
      'time': time,
      'tdId': tdId,
      'marked': marked,
      'subject': subject,
    };
  }
}
