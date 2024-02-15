import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gncms_clone/getX/data/model/attendance_model.dart';
import 'package:gncms_clone/getX/data/model/database_model.dart';
import 'package:gncms_clone/getX/data/model/student_attendance_model.dart';
import 'package:gncms_clone/getX/data/model/student_model.dart';
import 'package:gncms_clone/getX/data/model/teacher_model.dart';
import 'package:gncms_clone/getX/data/model/timetable_model.dart';

import '../utils/helpers/snackbar_helper.dart';

class FirestoreController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<TeacherModel?> getTeacher(dynamic data) async {
    if (data is String) {
      try {
        final snap = await _firestore
            .collection(DatabaseModel.teacherCollection)
            .doc(data)
            .get();

        if (snap.exists && snap.data() != null) {
          // Extract the data from the document
          Map<String, dynamic> userData = snap.data()!;
          return TeacherModel.fromJson(userData);
        } else {
          SnackBarHelper.showSnackBar(
              title: "Error",
              message: 'Document not found or empty',
              contentType: ContentType.failure);
          return null;
        }
      } catch (e) {
        SnackBarHelper.showSnackBar(
            title: "Error",
            message: 'Error getting student: $e',
            contentType: ContentType.failure);
      }
    } else {
      try {
        TeacherModel teacherModel = data as TeacherModel;
        final snap = await _firestore
            .collection(DatabaseModel.teacherCollection)
            .doc(teacherModel.id)
            .get();
        if (snap.exists && snap.data() != null) {
          // Extract the data from the document
          Map<String, dynamic> userData = snap.data()!;
          return TeacherModel.fromJson(userData);
        } else {
          SnackBarHelper.showSnackBar(
              title: "Error",
              message: 'Document not found or empty',
              contentType: ContentType.failure);
          return null;
        }
      } catch (e) {
        SnackBarHelper.showSnackBar(
            title: "Error",
            message: 'Error getting teacher: $e',
            contentType: ContentType.failure);
      }
    }
    return null;
  }

  Future<StudentModel?> getStudent(dynamic data) async {
    if (data is String) {
      try {
        final snap = await _firestore
            .collection(DatabaseModel.studentCollection)
            .doc(data)
            .get();
        if (snap.exists && snap.data() != null) {
          // Extract the data from the document
          Map<String, dynamic> userData = snap.data()!;
          return StudentModel.fromJson(userData);
        } else {
          SnackBarHelper.showSnackBar(
              title: "Error",
              message: 'Document not found or empty',
              contentType: ContentType.failure);
          return null;
        }
      } catch (e) {
        SnackBarHelper.showSnackBar(
            title: "Error",
            message: "Error getting student: $e",
            contentType: ContentType.failure);
      }
    } else {
      StudentModel studentModel = data as StudentModel;
      try {
        final snap = await _firestore
            .collection(DatabaseModel.studentCollection)
            .doc(studentModel.id)
            .get();
        if (snap.exists && snap.data() != null) {
          // Extract the data from the document
          Map<String, dynamic> userData = snap.data()!;
          return StudentModel.fromJson(userData);
        } else {
          SnackBarHelper.showSnackBar(
              title: "Error",
              message: 'Document not found or empty',
              contentType: ContentType.failure);
          return null;
        }
      } catch (e) {
        print("Error getting student: $e");
      }
    }
    return null;
  }

  Future<DocumentReference<Map<String, dynamic>>?> addTeacher(
      TeacherModel teacherModel) async {
    try {
      return await _firestore
          .collection(DatabaseModel.teacherCollection)
          .add(teacherModel.toJson());
    } catch (e) {
      print("Error adding teacher: $e");
    }
    return null;
  }

  Future<DocumentReference<Map<String, dynamic>>?> addStudent(
      StudentModel studentModel) async {
    try {
      return await _firestore
          .collection(DatabaseModel.studentCollection)
          .add(studentModel.toJson());
    } catch (e) {
      print("Error adding student: $e");
    }
    return null;
  }

  Future<void> updateTeacher(
      {required TeacherModel teacherModel,
      required Map<String, dynamic> data}) async {
    try {
      return await _firestore
          .collection(DatabaseModel.teacherCollection)
          .doc(teacherModel.id)
          .update(data);
    } catch (e) {
      print("Error updating teacher: $e");
    }
  }

  Future<void> updateStudent(
      {required StudentModel studentModel,
      required Map<String, dynamic> data}) async {
    try {
      return await _firestore
          .collection(DatabaseModel.studentCollection)
          .doc(studentModel.id)
          .update(data);
    } catch (e) {
      print("Error updating student: $e");
    }
  }

  Future<List<AttendanceModel>> getListOfAttendanceModel(
      TeacherModel teacherModel) async {
    final List<AttendanceModel> listOfAttendanceModel = [];

    try {
      final branchAttendanceList = await _firestore
          .collection(DatabaseModel.attendanceCollection)
          .where('branch', isEqualTo: teacherModel.branch)
          .orderBy('semester')
          .orderBy('section')
          .get();
      for (final branchAttendance in branchAttendanceList.docs) {
        if (branchAttendance.exists && branchAttendance.data().isNotEmpty) {
          final data = branchAttendance.data();
          listOfAttendanceModel.add(AttendanceModel.fromJson(data, []));
        }
      }
    } catch (e) {
      SnackBarHelper.showSnackBar(
        title: "Error",
        message: "Error getting attendance models: $e",
        contentType: ContentType.failure,
      );
    }

    return listOfAttendanceModel;
  }

  Future<AttendanceModel> getListOfAttendanceDayModelForAttendanceModel(
      {required List<AttendanceModel> listOfAttendanceModel,
      required String semester,
      required String section,
      required TeacherModel teacherModel}) async {
    List<AttendanceDayModel> listOfAttendanceDayModel = [];
    AttendanceModel attendanceModel = listOfAttendanceModel
        .where((element) =>
            element.semester == semester && element.section == section)
        .first;

    if (attendanceModel.days.isNotEmpty) {
      return attendanceModel;
    } else {
      try {
        final days = await _firestore
            .collection(DatabaseModel.attendanceCollection)
            .doc(attendanceModel.id)
            .collection(DatabaseModel.dayCollection)
            .where('time', isLessThanOrEqualTo: DateTime.now())
            .orderBy('time')
            .get();
        for (final day in days.docs) {
          if (day.exists && day.data().isNotEmpty) {
            final slots = await _firestore
                .collection(DatabaseModel.attendanceCollection)
                .doc(attendanceModel.id)
                .collection(DatabaseModel.dayCollection)
                .doc(day.id)
                .collection(DatabaseModel.slotCollection)
                .orderBy('time')
                .get();
            final List<AttendanceSlotModel> listOfAttendanceSlotModel = [];
            for (final slot in slots.docs) {
              if (slot.exists && slot.data().isNotEmpty) {
                final slotModel = AttendanceSlotModel.fromJson(slot.data());

                if (slotModel.tdId == teacherModel.id && !slotModel.marked) {
                  listOfAttendanceSlotModel.add(slotModel);
                }
              }
            }
            if (listOfAttendanceSlotModel.isNotEmpty) {
              listOfAttendanceDayModel.add(AttendanceDayModel(
                id: day.id,
                slots: listOfAttendanceSlotModel,
                time: listOfAttendanceSlotModel.first.time,
              ));
            }
          }
        }
        attendanceModel.days.addAll(listOfAttendanceDayModel);
      } catch (e) {
        SnackBarHelper.showSnackBar(
          title: "Error",
          message: "Error getting attendance day & slot models: $e",
          contentType: ContentType.failure,
        );
      }
      return attendanceModel;
    }
  }

  Future<List<DayModel>> getTimetable({
    required String branch,
    required String semester,
    required String section,
  }) async {
    try {
      final timetableDocs = await _firestore
          .collection(DatabaseModel.timetableCollection)
          .where('branch', isEqualTo: branch)
          .where('semester', isEqualTo: semester)
          .where('section', isEqualTo: section)
          .get();

      final List<DayModel> timetableModel = [];

      for (final timetable in timetableDocs.docs) {
        final days = await _firestore
            .collection(DatabaseModel.timetableCollection)
            .doc(timetable.id)
            .collection(DatabaseModel.dayCollection)
            .orderBy('time')
            .get();

        final List<SlotModel> slotModels = [];

        for (final day in days.docs) {
          if (day.exists && day.data().isNotEmpty) {
            final slots = await _firestore
                .collection(DatabaseModel.timetableCollection)
                .doc(timetable.id)
                .collection(DatabaseModel.dayCollection)
                .doc(day.id)
                .collection(DatabaseModel.slotCollection)
                .orderBy('time')
                .get();

            for (final slot in slots.docs) {
              if (slot.exists && slot.data().isNotEmpty) {
                slotModels.add(SlotModel.fromFirestore(slot.data()));
              }
            }
            if (slotModels.isNotEmpty) {
              timetableModel.add(DayModel(
                id: day.id,
                slots: slotModels,
                time: slotModels.first.time,
              ));
            }
          }
        }
      }
      return timetableModel;
    } catch (e) {
      SnackBarHelper.showSnackBar(
        title: "Error",
        message: "Error getting timetable: $e",
        contentType: ContentType.failure,
      );
    }
    return [];
  }

  Future<(List<StudentModel>, List<String>)> getStudentList(
      {required String branch,
      required String semester,
      required String section}) async {
    List<StudentModel> students = [];
    List<String> studentIds = [];
    try {
      final snap = await _firestore
          .collection(DatabaseModel.studentCollection)
          .where('branch', isEqualTo: branch)
          .where('semester', isEqualTo: semester)
          .where('section', isEqualTo: section)
          .orderBy('usn')
          .get();
      if (snap.docs.isNotEmpty) {
        // Iterate through the documents and convert them to StudentModel
        for (var doc in snap.docs) {
          final studentModel = StudentModel.fromJson(doc.data());
          students.add(studentModel);
          studentIds.add(studentModel.id);
        }
      }
      return (students, studentIds);
    } catch (e) {
      SnackBarHelper.showSnackBar(
          title: "Error",
          message: "Error getting students list: $e",
          contentType: ContentType.failure);
    }
    return (students, studentIds);
  }

  Future<AttendanceModel?> getAttendanceModel(StudentModel studentModel) async {
    try {
      final attendanceModel = await _firestore
          .collection(DatabaseModel.attendanceCollection)
          .where("branch", isEqualTo: studentModel.branch)
          .where("semester", isEqualTo: studentModel.semester)
          .where("section", isEqualTo: studentModel.section)
          .get()
          .then((value) =>
              AttendanceModel.fromJson(value.docs.single.data(), []));
      final days = await _firestore
          .collection(DatabaseModel.attendanceCollection)
          .doc(attendanceModel.id)
          .collection(DatabaseModel.dayCollection)
          .where('time', isLessThanOrEqualTo: DateTime.now())
          .orderBy('time')
          .get();
      List<AttendanceDayModel> listOfAttendanceDayModel = [];
      for (final day in days.docs) {
        if (day.exists && day.data().isNotEmpty) {
          final slots = await _firestore
              .collection(DatabaseModel.attendanceCollection)
              .doc(attendanceModel.id)
              .collection(DatabaseModel.dayCollection)
              .doc(day.id)
              .collection(DatabaseModel.slotCollection)
              .orderBy('time')
              .get();
          final List<AttendanceSlotModel> listOfAttendanceSlotModel = [];
          for (final slot in slots.docs) {
            if (slot.exists && slot.data().isNotEmpty) {
              final slotModel = AttendanceSlotModel.fromJson(slot.data());

              listOfAttendanceSlotModel.add(slotModel);
            }
          }
          if (listOfAttendanceSlotModel.isNotEmpty) {
            listOfAttendanceDayModel.add(AttendanceDayModel(
              id: day.id,
              slots: listOfAttendanceSlotModel,
              time: listOfAttendanceSlotModel.first.time,
            ));
          }
        }
      }
      attendanceModel.days.addAll(listOfAttendanceDayModel);

      return attendanceModel;
    } catch (e) {
      SnackBarHelper.showSnackBar(
          title: "Error",
          message: "Error getting attendance model for Student: $e",
          contentType: ContentType.failure);
    }
    return null;
  }

  Future<bool> addStudentAttendance(StudentModel studentModel,
      StudentAttendanceModel studentAttendanceModel) async {
    try {
      final refDoc = await _firestore
          .collection(DatabaseModel.studentCollection)
          .doc(studentModel.id)
          .collection(DatabaseModel.studentAttendanceCollection)
          .add({'semester': studentModel.semester});

      await _firestore
          .collection(DatabaseModel.studentCollection)
          .doc(studentModel.id)
          .collection(DatabaseModel.studentAttendanceCollection)
          .doc(refDoc.id)
          .update({'id': refDoc.id});

      print(studentAttendanceModel.listOfSemesterAttendance);

      for (var slot in studentAttendanceModel.listOfSemesterAttendance) {
        final doc = await _firestore
            .collection(DatabaseModel.studentCollection)
            .doc(studentModel.id)
            .collection(DatabaseModel.studentAttendanceCollection)
            .doc(refDoc.id)
            .collection(DatabaseModel.slotCollection)
            .add(slot.toMap());
        await _firestore
            .collection(DatabaseModel.studentCollection)
            .doc(studentModel.id)
            .collection(DatabaseModel.studentAttendanceCollection)
            .doc(refDoc.id)
            .collection(DatabaseModel.slotCollection)
            .doc(doc.id)
            .update({'id': doc.id});
      }
      return true;
    } catch (e) {
      SnackBarHelper.showSnackBar(
        title: "Error",
        message: "Error adding student attendance: $e",
        contentType: ContentType.failure,
      );
      return false;
    }
  }

  Future<List<StudentAttendanceModel>> getStudentAttendance(
      StudentModel studentModel) async {
    final List<StudentAttendanceModel> listOfStudentAttendance = [];

    try {
      final snap = await _firestore
          .collection(DatabaseModel.studentCollection)
          .doc(studentModel.id)
          .collection(DatabaseModel.studentAttendanceCollection)
          .get();

      for (final doc in snap.docs) {
        if (doc.exists && doc.data().isNotEmpty) {
          final slots = await _firestore
              .collection(DatabaseModel.studentCollection)
              .doc(studentModel.id)
              .collection(DatabaseModel.studentAttendanceCollection)
              .doc(doc.id)
              .collection(DatabaseModel.slotCollection)
              .get();

          List<SemesterAttendanceModel> listOfSemesterAttendance = [];
          print(slots.docs.length);
          for (final slot in slots.docs) {
            if (slot.exists && slot.data().isNotEmpty) {
              listOfSemesterAttendance
                  .add(SemesterAttendanceModel.fromJson(slot.data()));
            }
          }
          listOfStudentAttendance.add(StudentAttendanceModel.fromJson(
              doc.data(), listOfSemesterAttendance));
        }
      }
    } catch (e) {
      SnackBarHelper.showSnackBar(
        title: "Error",
        message: "Error getting student attendance: $e",
        contentType: ContentType.failure,
      );
    }
    return listOfStudentAttendance;
  }

  Future<void> addAttendance(
      {required Map<String, dynamic> args,
      required List<String> present,
      required List<String> absent}) async {
    try {
      await _firestore
          .collection(DatabaseModel.attendanceCollection)
          .doc(args["attendanceModelId"])
          .collection(DatabaseModel.dayCollection)
          .doc(args["attendanceDayModelId"])
          .collection(DatabaseModel.slotCollection)
          .doc(args["attendanceSlotModelId"])
          .update({"present": present, "absent": absent, "marked": true});

      SnackBarHelper.showSnackBar(
        title: "Success",
        message: "Added successfully",
        contentType: ContentType.success,
      );
    } catch (e) {
      SnackBarHelper.showSnackBar(
        title: "Error",
        message: "Error adding attendance: $e",
        contentType: ContentType.failure,
      );
    }
  }
}
