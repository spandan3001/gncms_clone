import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SingingCharacter { teacher, student }

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
  static Map<String, dynamic> globalCurrentSubjects = {};
  static Map<String, dynamic> globalUserAttendance = {};
  static Table globalDayTableData = Table();
  static Table globalDayTableHeader = Table();
  static String globalCurrentUser = "";
  static String globalUserId = "";
  static String globalEmail = "";
  static String globalUserBranch = "";
  static String globalCurrentSem = "";
  static String globalCurrentBatch = "";
  static String _currentUser = "";

  static Future<void> initGlobalData() async {
    globalDayTableHeader = Table();
    globalDayTableData = Table();
    globalData = {};
    globalUserBatchDetails = {};
    globalUserAllTotalPercentage = {};
    globalCurrentSubjects = {};
    globalUserAttendance = {};
    globalCurrentUser = "";
    globalUserId = "";
    globalEmail = "";
    globalUserBranch = "";
    globalCurrentSem = "";
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

    if (globalCurrentUser == SingingCharacter.teacher.name) {
      getTeacher(snap3);
    } else if (globalCurrentUser == SingingCharacter.student.name) {
      String semNotation = "sem-${dataUser['sem']}";
      //globalUserBatch = snap3.data()![semNotation];
      //print(globalUserBatch);
      String sectionNotation = "section-${dataUser['section']}";
      await getStudent(snap3, semNotation, sectionNotation);
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
