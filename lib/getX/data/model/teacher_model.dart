// To parse this JSON data, do
//
//     final teacherModel = teacherModelFromJson(jsonString);

import 'dart:convert';

class TeacherModel {
  String? designation;
  String email;
  String firstName;
  String? lastName;
  String? phoneNo;
  String userType;

  TeacherModel({
    this.designation,
    required this.userType,
    required this.email,
    required this.firstName,
    this.lastName,
    this.phoneNo,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) => TeacherModel(
        designation: json["designation"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNo: json["phoneNo"],
        userType: json["userType"],
      );

  Map<String, String> toJson() {
    return {
      "designation": designation ?? '',
      "email": email,
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
