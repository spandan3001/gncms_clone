// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

class StudentModel {
  String email;
  String userType;
  String firstName;
  String? fatherName;
  String? motherName;
  String? fatherEmail;
  String? fatherPhoneNo;
  String? guardianPhoneNo;
  String? lastName;
  String? motherEmail;
  String? motherPhoneNo;
  String? phoneNo;

  StudentModel({
    required this.email,
    required this.userType,
    required this.firstName,
    this.fatherEmail,
    this.fatherName,
    this.fatherPhoneNo,
    this.guardianPhoneNo,
    this.lastName,
    this.motherEmail,
    this.motherName,
    this.motherPhoneNo,
    this.phoneNo,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        email: json["email"],
        fatherEmail: json["fatherEmail"],
        fatherName: json["fatherName"],
        fatherPhoneNo: json["fatherPhoneNo"],
        firstName: json["firstName"],
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
      'fatherName': fatherName ?? '',
      'fatherPhoneNo': fatherPhoneNo ?? '',
      'firstName': firstName,
      'guardianPhoneNo': guardianPhoneNo ?? '',
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
