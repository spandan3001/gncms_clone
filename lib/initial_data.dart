import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

InitialData globalObj = InitialData();

class InitialData extends ChangeNotifier {
  FirebaseFirestore database = FirebaseFirestore.instance;
  late SharedPreferences prefs;

  Future<void> initLocalData() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Map<String, dynamic> globalData = {};
  static Map<String, double> globalUserAllTotalPercentage = {};
  static Map<String, dynamic> globalUserBatchDetails = {};
  static Map<String, dynamic> globalCurrentTimeTable = {};
  static Map<String, dynamic> globalCurrentSubjects = {};
  static Map<String, dynamic> globalUserAttendance = {};
  static String globalCurrentUser = "";
  static Map<String, dynamic> globalSelectedAttendance = {};
  static String globalUserSem = "";
  static String globalUserSection = "";
  static String globalUserId = "";
  static String globalEmail = "";
  static String globalUserBranch = "";
  static String globalSelectedSem = "";
  static String globalCurrentBatch = "";
  static String _currentUser = "";

  static Future<void> initGlobalData() async {
    globalData = {};
    globalUserSem = "";
    globalSelectedAttendance = {};
    globalUserSection = "";
    globalUserBatchDetails = {};
    globalCurrentTimeTable = {};
    globalUserAllTotalPercentage = {};
    globalCurrentSubjects = {};
    globalUserAttendance = {};
    globalCurrentUser = "";
    globalUserId = "";
    globalEmail = "";
    globalUserBranch = "";
    globalSelectedSem = "";
    globalCurrentBatch = "";
    await globalObj.writeInitGlobalData();
  }

  Future<void> writeInitGlobalData() async {
    initLocalData();

    await prefs.remove('currentUser');
  }

  Future<void> writeLocalData(
      {required String currentUser,
      required String email,
      required String userId}) async {
    await initLocalData();
    String data =
        jsonEncode({'user': currentUser, 'email': email, 'userId': userId});
    await prefs.setString('currentUser', data);
    //print(data);
  }

  Future getCurrentUserAttendance() async {
    var snap =
        await database.collection('slotAttendance').doc(globalUserBranch).get();
    if (snap.data()![globalCurrentBatch][globalSelectedSem]
            [globalUserSection] ==
        null) {
      globalSelectedAttendance = {};
    } else {
      globalSelectedAttendance = snap.data()![globalCurrentBatch]
          [globalSelectedSem][globalUserSection];
    }
    //sort

    List<MapEntry<String, dynamic>> listData =
        globalSelectedAttendance.entries.toList();

    // print(value);

    listData.sort((a, b) => int.parse(a.key).compareTo(int.parse(b.key)));
    globalSelectedAttendance = Map.fromEntries(listData);
  }

  Future<void> getCurrentTimeTable() async {
    var snap =
        await database.collection('timeTable').doc(globalUserBranch).get();
    globalCurrentTimeTable = snap.data()![globalUserSem][globalUserSection];
  }

  void getLocalData() {
    _currentUser = prefs.getString('currentUser') ?? "";
  }

  Future<void> getUser() async {
    //get the current user
    await initLocalData();
    getLocalData();
    if (_currentUser.isNotEmpty) {
      Map<String, dynamic> data = jsonDecode(_currentUser);
      globalCurrentUser = data['user'];
      globalUserId = data['userId'];
      globalEmail = data['email'];
      await getUserDetails();
      await getSubject();
    }
  }

  Future<void> getSubject() async {
    final snap =
        await database.collection('subject').doc(globalUserBranch).get();
    globalCurrentSubjects = snap.data()!;
  }

  Future<void> getAttendance() async {
    final snap =
        await database.collection('attendance').doc(globalUserBranch).get();
    globalUserBatchDetails = snap.data()![globalCurrentBatch]['details'];
    globalUserAttendance =
        snap.data()![globalCurrentBatch]['student'][globalUserId];
    List<MapEntry<String, dynamic>> listData =
        globalUserAttendance.entries.toList();

    listData.sort((a, b) => b.key.compareTo(a.key));

    globalUserAttendance = Map.fromEntries(listData);
    //print(globalUserAttendance);
  }

  Future<void> getUserDetails() async {
    //get brief info abt the user
    final snap2 =
        await database.collection('users').doc(globalCurrentUser).get();
    final dataUser = snap2.data()![globalEmail];
    globalUserBranch = dataUser['branch'];

    //actual data
    final snap3 = await database
        .collection(globalCurrentUser)
        .doc(globalUserBranch)
        .get();

    if (globalCurrentUser == UserType.teacher.name) {
      getTeacher(snap3);
    } else if (globalCurrentUser == UserType.student.name) {
      globalUserSem = "sem-${dataUser['sem']}";
      //globalUserBatch = snap3.data()![globalUserSem];
      //print(globalUserBatch);
      globalUserSection = "section-${dataUser['section']}";
      await getStudent(snap3, globalUserSem, globalUserSection);
    }
  }

  Future<void> getStudent(DocumentSnapshot<Map<String, dynamic>> snapshot,
      String semNotation, String sectionNotation) async {
    globalCurrentBatch = snapshot.data()![semNotation]['batch'];
    globalData = snapshot.data()![semNotation][sectionNotation][globalUserId];
  }

  Future<void> getTeacher(
      DocumentSnapshot<Map<String, dynamic>> snapshot) async {
    globalData = snapshot.data()![globalUserId];
  }
}

//   String firstName = '',
//       lastName = '',
//       usn = '1MV20CS136',
//       phoneNo = '',
//       email = '',
//       fatherPhoneNo = '',
//       fatherEmail = '',
//       motherPhoneNo = '',
//       motherEmail = '',
//       guardianPhoneNo = '',
//       guardianEmail = '';
// }
