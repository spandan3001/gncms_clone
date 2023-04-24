import 'package:cloud_firestore/cloud_firestore.dart';

Map<String, dynamic> data = {};

String usn = '1MV20CS136';

runMate() async {
  var snap =
      await FirebaseFirestore.instance.collection('students').doc(usn).get();
  data = snap.data()!;

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
