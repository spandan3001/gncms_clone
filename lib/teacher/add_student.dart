import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../user_login_in/common/theme_helper.dart';

class AddStudent extends StatelessWidget {
  AddStudent({Key? key}) : super(key: key);

  static const id = '/add_student';

  bool isValid(Map<String, String> studentData) {
    for (var data in studentData.values) {
      if (data.isEmpty) {
        return false;
      }
    }
    return true;
  }

  Map<String, String> studentData = {
    'firstName': '',
    'lastName': '',
    'usn': '',
    'phoneNo': '',
    'email': '',
    'fatherPhoneNo': '',
    'fatherEmail': '',
    'motherPhoneNo': '',
    'motherEmail': '',
    'guardianPhoneNo': '',
    'guardianEmail': ''
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddStudent'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        TextField(
                          onChanged: (String value) {
                            studentData['firstName'] = value;
                          },
                          decoration: ThemeHelper().textInputDecoration(
                              'First Name', 'Enter your First Name'),
                        ),
                        const SizedBox(height: 30.0),
                        TextField(
                          onChanged: (value) {
                            studentData['lastName'] = value;
                          },
                          decoration: ThemeHelper().textInputDecoration(
                              'Last Name', 'Enter your Last Name'),
                        ),
                        const SizedBox(height: 30.0),
                        TextField(
                          onChanged: (value) {
                            studentData['usn'] = value;
                          },
                          decoration: ThemeHelper()
                              .textInputDecoration('USN', 'Enter your USN'),
                        ),
                        const SizedBox(height: 30.0),
                        TextField(
                          onChanged: (value) {
                            studentData['phoneNo'] = value;
                          },
                          decoration: ThemeHelper().textInputDecoration(
                              'PhoneNo', 'Enter your Phone No'),
                        ),
                        const SizedBox(height: 30.0),
                        TextField(
                          onChanged: (value) {
                            studentData['email'] = value;
                          },
                          decoration: ThemeHelper()
                              .textInputDecoration('Email', 'Enter your Email'),
                        ),
                        const SizedBox(height: 30.0),
                        TextField(
                          onChanged: (value) {
                            studentData['fatherPhoneNo'] = value;
                          },
                          decoration: ThemeHelper().textInputDecoration(
                              'Father PhoneNo', 'Enter your Father Phone No'),
                        ),
                        const SizedBox(height: 30.0),
                        TextField(
                          onChanged: (value) {
                            studentData['fatherEmail'] = value;
                          },
                          decoration: ThemeHelper().textInputDecoration(
                              'Father Email', 'Enter your Father Email'),
                        ),
                        const SizedBox(height: 30.0),
                        TextField(
                          onChanged: (value) {
                            studentData['motherPhoneNo'] = value;
                          },
                          decoration: ThemeHelper().textInputDecoration(
                              'Mother PhoneNo', 'Enter your Mother Phone No'),
                        ),
                        const SizedBox(height: 30.0),
                        TextField(
                          onChanged: (value) {
                            studentData['motherEmail'] = value;
                          },
                          decoration: ThemeHelper().textInputDecoration(
                              'Mother Email', 'Enter your Mother Email'),
                        ),
                        const SizedBox(height: 30.0),
                        TextField(
                          onChanged: (value) {
                            studentData['guardianPhoneNo'] = value;
                          },
                          decoration: ThemeHelper().textInputDecoration(
                              'Guardian PhoneNo',
                              'Enter your Guardian Phone No'),
                        ),
                        const SizedBox(height: 30.0),
                        TextField(
                          onChanged: (value) {
                            studentData['guardianEmail'] = value;
                          },
                          decoration: ThemeHelper().textInputDecoration(
                              'Guardian Email', 'Enter your Mother Email'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            SizedBox(
              height: (MediaQuery.of(context).size.height * 6) / 100,
              child: ElevatedButton(
                  style: ThemeHelper().buttonStyle(Colors.black),
                  child: Text(
                    'Submit'.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    if (isValid(studentData)) {
                      var snap = FirebaseFirestore.instance
                          .collection('student')
                          .doc(studentData['usn']);
                      snap.set(studentData);
                      Navigator.pop(context);
                      print('pressed inside');
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
