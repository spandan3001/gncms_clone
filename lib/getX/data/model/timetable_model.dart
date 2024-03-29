import 'package:cloud_firestore/cloud_firestore.dart';

class TimetableModel {
  final String id;
  final String branch;
  final String section;
  final String semester;
  final List<DayModel> days;

  TimetableModel({
    required this.id,
    required this.branch,
    required this.section,
    required this.semester,
    required this.days,
  });

  factory TimetableModel.fromFirestore(Map<String, dynamic> data) {
    return TimetableModel(
      branch: data['branch'] ?? "",
      section: data['section'] ?? "",
      semester: data['semester'] ?? "",
      days: data['days'],
      id: data['id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'branch': branch,
      'section': section,
      'semester': semester,
      'id': id
    };
  }
}

class DayModel {
  final String id;
  final DateTime time;
  final List<SlotModel> slots;

  DayModel({
    required this.id,
    required this.slots,
    required this.time,
  });

  factory DayModel.fromFirestore(Map<String, dynamic> data) {
    Timestamp timestamp = data['time'];
    final dateTime = timestamp.toDate();
    return DayModel(
      id: data['id'] ?? "",
      time: dateTime,
      slots: data['days'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'time': time};
  }
}

class SlotModel {
  final String class_;
  final String subject;
  final String id;
  final String tdId;
  final DateTime time;

  SlotModel({
    required this.class_,
    required this.tdId,
    required this.subject,
    required this.id,
    required this.time,
  });

  factory SlotModel.fromFirestore(Map<String, dynamic> data) {
    Timestamp timestamp = data['time'];
    final dateTime = timestamp.toDate();
    return SlotModel(
        class_: data['class'],
        tdId: data['tdId'],
        subject: data['subject'] ?? "",
        id: data['id'],
        time: dateTime);
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'time': time,
      'class': class_,
      'tdId': tdId,
      'subject': subject
    };
  }
}
