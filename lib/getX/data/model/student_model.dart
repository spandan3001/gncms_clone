// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

class StudentModel {
  String id;
  String email;
  String usn;
  String userType;
  String firstName;
  String branch;
  String semester;
  String section;
  String? fatherName;
  String? motherName;
  String? fatherEmail;
  String? fatherPhoneNo;
  String? lastName;
  String? motherEmail;
  String? motherPhoneNo;
  String? phoneNo;

  StudentModel({
    required this.email,
    required this.id,
    required this.userType,
    required this.usn,
    required this.firstName,
    required this.semester,
    required this.branch,
    required this.section,
    this.fatherEmail,
    this.fatherName,
    this.fatherPhoneNo,
    this.lastName,
    this.motherEmail,
    this.motherName,
    this.motherPhoneNo,
    this.phoneNo,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        id: json["id"],
        email: json["email"],
        firstName: json["firstName"],
        userType: json["userType"],
        semester: json['semester'],
        usn: json['usn'],
        branch: json["branch"],
        section: json["section"],
        fatherEmail: json["fatherEmail"] ?? "",
        fatherName: json["fatherName"] ?? "",
        fatherPhoneNo: json["fatherPhoneNo"] ?? "",
        lastName: json["lastName"] ?? "",
        motherEmail: json["motherEmail"] ?? "",
        motherName: json["motherName"] ?? "",
        motherPhoneNo: json["motherPhoneNo"] ?? "",
        phoneNo: json["phoneNo"] ?? "",
      );

  Map<String, String> toJson() {
    return {
      'id': id,
      'email': email,
      'semester': semester,
      'section': section,
      'branch': branch,
      'usn': usn,
      'firstName': firstName,
      'userType': userType,
      'fatherEmail': fatherEmail ?? '',
      'fatherName': fatherName ?? '',
      'fatherPhoneNo': fatherPhoneNo ?? '',
      'lastName': lastName ?? '',
      'motherEmail': motherEmail ?? '',
      'motherName': motherName ?? '',
      'motherPhoneNo': motherPhoneNo ?? '',
      'phoneNo': phoneNo ?? '',
    };
  }

  static StudentModel studentModelFromJson(String str) =>
      StudentModel.fromJson(json.decode(str));

  static String studentModelToJson(StudentModel data) =>
      json.encode(data.toJson());
}
