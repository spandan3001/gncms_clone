import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseFirestore database = FirebaseFirestore.instance;
late SharedPreferences prefs;

Future<void> initLocalData() async {
  prefs = await SharedPreferences.getInstance();
}

enum SingingCharacter { teacher, student }

Map<String, dynamic> globalData = {};
String globalCurrentUser = "";
String globalUserId = "";
String globalEmail = "";

Future<void> writeLocalData(
    {required String currentUser,
    required String email,
    required String userId}) async {
  initLocalData();
  String data =
      jsonEncode({'user': currentUser, 'email': email, 'userId': userId});
  await prefs.setString('currentUser', data);
  //print(data);
}

Future<void> getUser() async {
  //get the current user
  await initLocalData();
  final String action = prefs.getString('currentUser') ?? "";
  if (action.isNotEmpty) {
    Map<String, dynamic> data = jsonDecode(action);
    globalCurrentUser = data['user'];
    globalUserId = data['userId'];
    globalEmail = data['email'];
    await getUserDetails();
  }
}

Future<void> getUserDetails() async {
  print("$globalUserId  $globalCurrentUser $globalEmail");
  //get brief info abt the user
  final snap2 = await database.collection('users').doc(globalCurrentUser).get();
  final dataUser = snap2.data()![globalEmail];

  //actual data
  final snap3 = await database
      .collection(globalCurrentUser)
      .doc(dataUser['branch'])
      .get();

  if (globalCurrentUser == SingingCharacter.teacher.name) {
    getTeacher(snap3);
  } else if (globalCurrentUser == SingingCharacter.student.name) {
    String semNotation = "sem-${dataUser['sem']}";
    String sectionNotation = "section-${dataUser['section']}";
    await getStudent(snap3, semNotation, sectionNotation);
  }
  print("in it $globalUserId");
}

Future<void> getStudent(DocumentSnapshot<Map<String, dynamic>> snapshot,
    String semNotation, String sectionNotation) async {
  globalData = snapshot.data()![semNotation][sectionNotation][globalUserId];
}

Future<void> getTeacher(DocumentSnapshot<Map<String, dynamic>> snapshot) async {
  globalData = snapshot.data()![globalUserId];
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
