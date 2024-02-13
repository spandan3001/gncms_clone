import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gncms_clone/getX/data/model/attendance_model.dart';
import 'package:gncms_clone/getX/data/model/database_model.dart';
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

  Future<QuerySnapshot<Map<String, dynamic>>> testGc() async {
    return await _firestore
        .collectionGroup("Slots")
        .where('tdId', isEqualTo: 'w3UYpxjTHyRH1R31zg8gIIHwxz42')
        .get();
  }

  Future<List<TimetableModel>> getClassForTeacher({
    required TeacherModel teacherModel,
  }) async {
    final List<TimetableModel> listOfTimetable = [];

    try {
      final branchTimetables = await _firestore
          .collection(DatabaseModel.timetableCollection)
          .where('branch', isEqualTo: teacherModel.branch)
          .get();

      for (final branchTimetable in branchTimetables.docs) {
        if (branchTimetable.exists && branchTimetable.data().isNotEmpty) {
          final days = await _firestore
              .collection(DatabaseModel.timetableCollection)
              .doc(branchTimetable.id)
              .collection(DatabaseModel.dayCollection)
              .get();

          final List<DayModel> listOfDayModel = [];
          for (final day in days.docs) {
            if (day.exists && day.data().isNotEmpty) {
              final slots = await _firestore
                  .collection(DatabaseModel.timetableCollection)
                  .doc(branchTimetable.id)
                  .collection(DatabaseModel.dayCollection)
                  .doc(day.id)
                  .collection(DatabaseModel.slotCollection)
                  .orderBy('time')
                  .get();
              final List<SlotModel> listOfSlotModel = [];
              for (final slot in slots.docs) {
                if (slot.exists && slot.data().isNotEmpty) {
                  final slotModel = SlotModel.fromFirestore(slot.data());

                  if (slotModel.tdId == teacherModel.id) {
                    listOfSlotModel.add(slotModel);
                  }
                }
              }
              if (listOfSlotModel.isNotEmpty) {
                listOfDayModel.add(DayModel(
                  id: day.id,
                  slots: listOfSlotModel,
                  time: listOfSlotModel.first.time,
                ));
              }
            }
          }
          if (listOfDayModel.isNotEmpty) {
            final data = branchTimetable.data();
            listOfTimetable.add(TimetableModel(
                branch: data['branch'],
                section: data['section'],
                semester: data['semester'],
                days: listOfDayModel));
          }
        }
      }
    } catch (e) {
      SnackBarHelper.showSnackBar(
        title: "Error",
        message: "Error getting teachers classes: $e",
        contentType: ContentType.failure,
      );
    }
    return listOfTimetable;
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
      print(timetableModel.length);
      print("-----------------------------------------");
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

  Future<List<StudentModel>> getStudentList(
      {required String branch,
      required String semester,
      required String section}) async {
    try {
      List<StudentModel> students = [];
      final snap = await _firestore
          .collection(DatabaseModel.studentCollection)
          .where('branch', isEqualTo: branch)
          .where('semester', isEqualTo: semester)
          .where('section', isEqualTo: section)
          .get();
      if (snap.docs.isNotEmpty) {
        // Iterate through the documents and convert them to StudentModel
        students =
            snap.docs.map((doc) => StudentModel.fromJson(doc.data())).toList();
      }
      return students;
    } catch (e) {
      SnackBarHelper.showSnackBar(
          title: "Error",
          message: "Error getting students list: $e",
          contentType: ContentType.failure);
    }
    return [];
  }

  Future<void> addTimetable(
      String timetableId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('Timetable').doc(timetableId).set(data);
    } catch (e) {
      print("Error adding class: $e");
    }
  }

  Future<void> updateTimetableId(
      String timetableId, Map<String, dynamic> data) async {
    try {
      await _firestore.doc(timetableId).update(data);
    } catch (e) {
      print("Error updating class: $e");
    }
  }

  Future<DocumentSnapshot?> getBranch(String branchId) async {
    try {
      return await _firestore.collection('Branches').doc(branchId).get();
    } catch (e) {
      print("Error getting branch: $e");
      return null;
    }
  }

  Future<void> addBranch(String branchId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('Branches').doc(branchId).set(data);
    } catch (e) {
      print("Error adding branch: $e");
    }
  }

  Future<void> updateBranch(String branchId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('Branches').doc(branchId).update(data);
    } catch (e) {
      print("Error updating branch: $e");
    }
  }

  Future<List<AttendanceSlotModel>?> getAttendance(
      StudentModel studentModel) async {
    try {
      List<AttendanceSlotModel> attendanceList = [];

      //return attendanceList;
      final data = await _firestore
          .collection(DatabaseModel.attendanceCollection)
          .where("branch", isEqualTo: studentModel.branch)
          .where("semester", isEqualTo: studentModel.semester)
          .where("section", isEqualTo: studentModel.section)
          .get()
          .then(
        (value) {
          return _firestore
              .collection(DatabaseModel.attendanceCollection)
              .doc(value.docs.single.id)
              .collection(DatabaseModel.dayCollection)
              .get();
        },
      );
      for (var element in data.docs) {
        attendanceList.add(AttendanceSlotModel.fromJson(element.data()));
      }
      return attendanceList;
    } catch (e) {
      print("Error getting attendance: $e");
    }
    return null;
  }

  Future<void> addAttendance(String branchId, String semesterId,
      String sectionId, String date, Map<String, dynamic> data) async {
    try {
      await _firestore
          .collection('Branches')
          .doc(branchId)
          .collection('Semesters')
          .doc(semesterId)
          .collection('Sections')
          .doc(sectionId)
          .collection('Attendance')
          .doc(date)
          .set(data);
    } catch (e) {
      print("Error adding attendance: $e");
    }
  }

  Future<void> updateAttendance(String branchId, String semesterId,
      String sectionId, String date, Map<String, dynamic> data) async {
    try {
      await _firestore
          .collection('Branches')
          .doc(branchId)
          .collection('Semesters')
          .doc(semesterId)
          .collection('Sections')
          .doc(sectionId)
          .collection('Attendance')
          .doc(date)
          .update(data);
    } catch (e) {
      print("Error updating attendance: $e");
    }
  }
}
