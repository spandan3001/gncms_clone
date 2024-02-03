// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

class StudentModel {
  String email;
  String? fatherEmail;
  String fatherName;
  String? fatherPhoneNo;
  String firstName;
  String? guardianEmail;
  String guardianName;
  String? guardianPhoneNo;
  String? lastName;
  String? motherEmail;
  String motherName;
  String? motherPhoneNo;
  String? phoneNo;
  String userType;

  StudentModel({
    required this.email,
    required this.userType,
    this.fatherEmail,
    required this.fatherName,
    this.fatherPhoneNo,
    required this.firstName,
    this.guardianEmail,
    required this.guardianName,
    this.guardianPhoneNo,
    this.lastName,
    this.motherEmail,
    required this.motherName,
    this.motherPhoneNo,
    this.phoneNo,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        email: json["email"],
        fatherEmail: json["fatherEmail"],
        fatherName: json["fatherName"],
        fatherPhoneNo: json["fatherPhoneNo"],
        firstName: json["firstName"],
        guardianEmail: json["guardianEmail"],
        guardianName: json["guardianName"],
        guardianPhoneNo: json["guardianPhoneNo"],
        lastName: json["lastName"],
        motherEmail: json["motherEmail"],
        motherName: json["motherName"],
        motherPhoneNo: json["motherPhoneNo"],
        phoneNo: json["phoneNo"],
        userType: json["userType"],
      );

  Map<String, String> toJson() {
    return {
      'email': email,
      'fatherEmail': fatherEmail ?? '',
      'fatherName': fatherName,
      'fatherPhoneNo': fatherPhoneNo ?? '',
      'firstName': firstName,
      'guardianEmail': guardianEmail ?? '',
      'guardianName': guardianName,
      'guardianPhoneNo': guardianPhoneNo ?? '',
      'lastName': lastName ?? '',
      'motherEmail': motherEmail ?? '',
      'motherName': motherName,
      'motherPhoneNo': motherPhoneNo ?? '',
      'phoneNo': phoneNo ?? '',
    };
  }

  static StudentModel studentModelFromJson(String str) =>
      StudentModel.fromJson(json.decode(str));

  static String studentModelToJson(StudentModel data) =>
      json.encode(data.toJson());
}
