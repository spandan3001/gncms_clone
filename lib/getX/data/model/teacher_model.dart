// To parse this JSON data, do
//
//     final teacherModel = teacherModelFromJson(jsonString);

import 'dart:convert';

class TeacherModel {
  String email;
  String id;
  String tId;
  String firstName;
  String branch;
  String? designation;
  String? lastName;
  String? phoneNo;
  String userType;

  TeacherModel({
    this.designation,
    required this.userType,
    required this.tId,
    required this.branch,
    required this.id,
    required this.email,
    required this.firstName,
    this.lastName,
    this.phoneNo,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) => TeacherModel(
        id: json['id'],
        tId: json['tId'],
        designation: json["designation"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNo: json["phoneNo"],
        userType: json["userType"],
        branch: json["branch"],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      "designation": designation ?? '',
      "email": email,
      "tId": tId,
      'branch': branch,
      "firstName": firstName,
      "lastName": lastName ?? '',
      "phoneNo": phoneNo ?? '',
      "userType": userType,
    };
  }

  static TeacherModel teacherModelFromJson(String str) =>
      TeacherModel.fromJson(json.decode(str));

  static String teacherModelToJson(TeacherModel data) =>
      json.encode(data.toJson());
}
