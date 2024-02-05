import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:gncms_clone/constants.dart';
import 'package:gncms_clone/getX/data/model/student_model.dart';
import 'package:gncms_clone/getX/data/model/teacher_model.dart';

class FirestoreController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>?> addStudent(
      StudentModel studentModel) async {
    try {
      DocumentReference<Map<String, dynamic>> snap =
          await _firestore.collection('students').add(studentModel.toJson());
      return snap.get();
    } catch (e) {
      // Handle error
      print('Error adding student: $e');
    }
    return null;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> addTeacher(
      TeacherModel teacherModel) async {
    try {
      DocumentReference<Map<String, dynamic>> snap =
          await _firestore.collection('teachers').add(teacherModel.toJson());
      return snap.get();
    } catch (e) {
      // Handle error
      print('Error adding teacher: $e');
    }
    return null;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> getDocument(
      UserType userType) async {
    try {
      // Get the current user
      User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        // Reference to Firestore collection based on userType

        // if()
        CollectionReference<Map<String, dynamic>> usersCollection =
            FirebaseFirestore.instance.collection('student');

        // Get the document for the current user
        DocumentSnapshot<Map<String, dynamic>> userDocument =
            await usersCollection.doc(currentUser.uid).get();

        // Return the document
        return userDocument;
      } else {
        // Handle the case when there is no current user
        throw Exception('No current user found.');
      }
    } catch (e) {
      // Handle errors
      print('Error in getDocument: $e');
    }
    return null;
  }
}
