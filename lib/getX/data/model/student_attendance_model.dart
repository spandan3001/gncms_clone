class StudentAttendanceModel {
  StudentAttendanceModel(
      {required this.semester,
      required this.listOfSemesterAttendance,
      required this.id});
  String semester;
  String id;
  List<SemesterAttendanceModel> listOfSemesterAttendance;

  factory StudentAttendanceModel.fromJson(Map<String, dynamic> data,
      List<SemesterAttendanceModel> listOfSemesterAttendance) {
    return StudentAttendanceModel(
        id: data['id'],
        semester: data['semester'],
        listOfSemesterAttendance: listOfSemesterAttendance);
  }
}

class SemesterAttendanceModel {
  String class_;
  String subject;
  String id;
  String present;
  String absent;

  SemesterAttendanceModel(
      {required this.class_,
      required this.subject,
      required this.absent,
      required this.id,
      required this.present});

  factory SemesterAttendanceModel.fromJson(Map<String, dynamic> data) {
    return SemesterAttendanceModel(
        class_: data['class'],
        id: data['id'],
        subject: data['subject'],
        absent: data['absent'].toString(),
        present: data['present'].toString());
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'class': class_,
      'subject': subject,
      'present': present,
      'absent': absent
    };
  }
}
