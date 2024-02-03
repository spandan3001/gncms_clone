import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseFirestore database = FirebaseFirestore.instance;
  var globalSnap = database.collection('students');

  var timeTable = {
    'sem-6': {
      'section-B': {
        'monday': {
          'slot-1': {
            'time': '09:00-09:55',
            'subject': '18CS61',
            'teacher': 'Ms. Mayuri.K.P'
          },
          'slot-2': {
            'time': '09:55-10:50',
            'subject': '18CS63',
            'teacher': 'Shobha'
          },
          'slot-3': {
            'time': '11:00-11:55',
            'subject': '18CS643',
            'teacher': 'Ms. DIVYA.V'
          },
          'slot-4': {
            'time': '11:55-12:55',
            'subject': '18IM652',
            'teacher': 'Mr. K JANARDANA'
          },
          'slot-5': {
            'time': '01:35-04:20',
            'subject': '18CSL67',
            'teacher': 'Pragathi'
          },
        },
        'tuesday': {
          'slot-1': {
            'time': '09:00-09:55',
            'subject': '18CS62',
            'teacher': 'Pragathi'
          },
          'slot-2': {
            'time': '09:55-10:50',
            'subject': '18CS61',
            'teacher': 'Ms. Mayuri.K.P'
          },
          'slot-3': {
            'time': '11:00-11:55',
            'subject': '18CS63',
            'teacher': 'Shobha'
          },
          'slot-4': {
            'time': '11:55-12:55',
            'subject': '18IM652',
            'teacher': 'Mr. K JANARDANA'
          },
          'slot-5': {
            'time': '1:35-04:20',
            'subject': '18CSMP69',
            'teacher': 'shobha'
          }
        },
        'wednesday': {
          'slot-1': {
            'time': '09:00-09:55',
            'subject': '18CS62',
            'teacher': 'Pragathi'
          },
          'slot-2': {
            'time': '09:55-10:50',
            'subject': '18CS643',
            'teacher': 'Ms. DIVYA.V'
          },
          'slot-3': {
            'time': '11:00-11:55',
            'subject': '18CS63',
            'teacher': 'Shobha'
          },
          'slot-4': {
            'time': '11:55-12:55',
            'subject': '18IM652',
            'teacher': 'Mr. K JANARDANA'
          },
        },
        'thursday': {
          'slot-1': {
            'time': '09:00-09:55',
            'subject': '18CS63',
            'teacher': 'Shobha'
          },
          'slot-2': {
            'time': '09:55-10:50',
            'subject': '18CS643',
            'teacher': 'Ms. DIVYA.V'
          },
          'slot-3': {
            'time': '11:00-11:55',
            'subject': '18CS62',
            'teacher': 'Pragathi'
          },
          'slot-4': {
            'time': '11:55-12:55',
            'subject': '18IM652',
            'teacher': 'Mr. K JANARDANA'
          },
          'slot-5': {
            'time': '01:35-04:20',
            'subject': '18CSL66',
            'teacher': 'Ms. MAYURI.K.P'
          }
        },
        'friday': {
          'slot-1': {
            'time': '09:00-09:55',
            'subject': '18CS61',
            'teacher': 'Ms. Mayuri.K.P'
          },
          'slot-2': {
            'time': '09:55-10:50',
            'subject': '18CS61',
            'teacher': 'Ms. Mayuri.K.P'
          },
          'slot-3': {
            'time': '11:00-11:55',
            'subject': '18CS62',
            'teacher': 'Pragathi'
          },
          'slot-4': {
            'time': '01:35-04:20',
            'subject': '18CSMP68',
            'teacher': 'KAVYASHREE'
          }
        },
      }
    }
  };

  //Map<String, dynamic> data = snap.data()!['1MV20CS136'];

  //List<MapEntry<String, dynamic>> listData = data.entries.toList();

  //listData.sort((a, b) => a.key.compareTo(b.key));

  //data = Map.fromEntries(listData);
  //print(data.keys);

  var attendance = {
    '2020-24': {
      'details': {
        'sem-1': {
          'start': DateTime(2020, 12, 27),
          'end': DateTime(2021, 4, 27)
        },
        'sem-2': {
          'start': DateTime(2021, 4, 27),
          'end': DateTime(2021, 12, 27)
        },
        'sem-3': {
          'start': DateTime(2021, 12, 31),
          'end': DateTime(2021, 12, 27)
        },
        'sem-4': {
          'start': DateTime(2021, 12, 31),
          'end': DateTime(2021, 12, 27)
        },
        'sem-5': {
          'start': DateTime(2021, 12, 31),
          'end': DateTime(2022, 12, 27)
        },
        'sem-6': {'start': DateTime(2022, 3, 11), 'end': DateTime(2023, 10, 27)}
      },
      'student': {
        '1MV20CS136': {
          'sem-6': {
            'details': {'totalPercentage': 0},
            'subject': {
              '18CS61': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CS62': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CS63': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CS643': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CSL66': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CSL67': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18IM652': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
            }
          },
          'sem-5': {
            'details': {'totalPercentage': 0},
            'subject': {
              '18CS51': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CS52': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CS53': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CS54': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CS55': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CS56': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CSL57': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CSL68': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CIV59': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
            }
          },
          'sem-4': {
            'details': {'totalPercentage': 0},
            'subject': {
              '18MAT41': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CS42': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CS43': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CS44': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CS45': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CS46': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CSL47': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CSL48': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18KVK49': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
            }
          },
          'sem-3': {
            'details': {'totalPercentage': 0},
            'subject': {
              '18MAT31': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CS32': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CS33': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CS34': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CS35': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CS36': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CSL37': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CSL38': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
              '18CPC39': {
                'total': 0,
                'present': 0,
                'details': 0,
              },
            },
          }
        }
      }
    }
  };

  var user = {
    "email": "soumya@gmail.com",
    "fatherEmail": "nagaraj@gmail.com",
    "fatherName": "Nagaraj M A",
    "fatherPhoneNo": "8548936685",
    "firstName": "Soumya",
    "guardianEmail": "arun@gmail.com",
    "guardianName": "Arun",
    "guardianPhoneNo": "9739259923",
    "lastName": "Gadad",
    "motherEmail": "shobha@gmail.com",
    "motherName": "Shobha H P",
    "motherPhoneNo": "9663446570",
    "phoneNo": "7204460288"
  };

  // var obj = {
  //   'sem-3': {
  //     '18MAT31': 'Transform Calculus, Fourier Series And Numerical Techniques',
  //     '18CS32': 'Data Structures and Applications',
  //     '18CS33': 'Analog and Digital Electronics',
  //     '18CS34': 'Computer Organization',
  //     '18CS35': 'Software Engineering',
  //     '18CS36': 'Discrete Mathematical Structures',
  //     '18CSL37': 'Analog and Digital Electronics Laboratory',
  //     '18CSL38': 'Data Structures Laboratory',
  //     '18CPC39': 'Constitution of India, Professional Ethics and Cyber Law',
  //   },
  //   'sem-4': {
  //     '18MAT41': 'Complex Analysis, Probability and Statistical Methods',
  //     '18CS42': 'Design and Analysis of Algorithms',
  //     '18CS43': 'Operating Systems',
  //     '18CS44': 'Microcontroller and Embedded Systems',
  //     '18CS45': 'Object Oriented Concepts',
  //     '18CS46': 'Data Communication',
  //     '18CSL47': 'Design and Analysis of Algorithm Laboratory',
  //     '18CSL48': 'Microcontroller and Embedded Systems Laboratory',
  //     '18KVK49': 'Vyavaharika Kannada',
  //   },
  //   'sem-5': {
  //     '18CS51': 'Management, Entrepreneurship for IT Industry',
  //     '18CS52': 'Computer Networks and Security',
  //     '18CS53': 'Database Management System',
  //     '18CS54': 'Automata theory and Computability',
  //     '18CS55': 'Application Development using Python',
  //     '18CS56': 'Unix Programming',
  //     '18CSL57': 'Computer Network Laboratory',
  //     '18CSL68': 'DBMS Laboratory with mini project',
  //     '18CIV59': 'Environmental Studies',
  //   },
  //   'sem-6': {
  //     '18CS61': 'System Software and Compilers',
  //     '18IM652': 'Data Analytics and Economics',
  //     '18CS62': 'Web Technology and its Applications',
  //     '18CSL67': 'Computer Graphics Laboratory with Mini Project',
  //     '18CSL66': 'System Software Laboratory',
  //     '18CS63': 'Web Technology and its Applications',
  //     '18CS643': 'Cloud Computing and its Applications',
  //     '18CSMP69': 'Web Development and Technology',
  //     '18CSMP68': 'Mobile ApplicationDevelopment'
  //   },
  //   'sem-7': {
  //     '18CS71': 'Artificial Intelligence and Machine Learning',
  //     '18CS72': 'Big Data Analytics',
  //     '18CS73X': 'Professional Elective – 2',
  //     '18CS74X': 'Professional Elective – 3',
  //     '18CS75X': 'Open Elective –B',
  //     '18CSL76': 'Artificial Intelligence and Machine Learning Laboratory',
  //     '18CSP78': 'Project Work Phase – 1'
  //   },
  //   'sem-8': {
  //     '18CS81': 'Internet of Things',
  //     '18CS82X': 'Professional Elective – 4',
  //     '18CSP83': 'Project Work Phase – 2',
  //     '18CSS84': 'Technical Seminar',
  //   },
  // };

  Map<String, dynamic> globalCurrentTimeTable = {};
  Future<void> getCurrentTimeTable() async {
    var snap = await database.collection('timeTable').doc('CS').get();
    globalCurrentTimeTable = snap.data()!['sem-6']['section-B'];

    Map<String, dynamic> listOfCards = {
      'monday': {},
      'tuesday': {},
      'wednesday': {},
      'thursday': {},
      'friday': {},
      'saturday': {},
    };

    //print(InitialData.globalCurrentTimeTable);
    Map<String, dynamic> temp;
    globalCurrentTimeTable.forEach((day, slots) {
      temp = slots;
      // to sort
      List<MapEntry<String, dynamic>> sortedEntries = temp.entries.toList()
        ..sort((a, b) => a.key.compareTo(b.key));
      temp = Map.fromEntries(sortedEntries);
      listOfCards[day] = temp;
    });
    globalCurrentTimeTable = listOfCards;
    //print(globalCurrentTimeTable);
  }

  Map<String, dynamic> slotAttendance = {
    '2020-24': {
      'details': {
        'sem-1': {
          'start': DateTime(2020, 12, 27),
          'end': DateTime(2021, 4, 27)
        },
        'sem-2': {
          'start': DateTime(2021, 4, 27),
          'end': DateTime(2021, 12, 27)
        },
        'sem-3': {
          'start': DateTime(2021, 12, 31),
          'end': DateTime(2021, 12, 27)
        },
        'sem-4': {
          'start': DateTime(2021, 12, 31),
          'end': DateTime(2021, 12, 27)
        },
        'sem-5': {
          'start': DateTime(2021, 12, 31),
          'end': DateTime(2022, 12, 27)
        },
        'sem-6': {'start': DateTime(2023, 3, 11), 'end': DateTime(2023, 10, 27)}
      },
      'sem-6': {'section-B': {}}
    }
  };

  void fillSlotData() async {
    await getCurrentTimeTable();
    DateTime start = DateTime(2023, 3, 14);
    DateTime end = DateTime.now();
    int i = 1;

    while (start.isBefore(end)) {
      slotAttendance['2020-24']!['sem-6']!['section-B']!['$i'] = {};
      slotAttendance['2020-24']!['sem-6']!['section-B']!['$i']['timeStamp'] =
          start;
      slotAttendance['2020-24']!['sem-6']!['section-B']!['$i']['subject'] = {};

      Map<String, dynamic> slots;
      //globalCurrentTimeTable.forEach((day, slots) {});

      globalCurrentTimeTable.forEach((slot, value) {
        slots = value;
        slots.forEach((key, value) {
          //print(value);

          String subject = value['subject'];

          slotAttendance['2020-24']!['sem-6']!['section-B']!['$i']['subject']
              [subject] = [
            '1MV20CS136',
            '1MV20CS135',
            '1MV20CS137',
            '1MV20CS134'
          ];
        });
      });
      start = DateTime(start.year, start.month, start.day + 1);
      i++;
    }
    //print(slotAttendance['2020-24']!['sem-6']!['section-B']);
  }

  fillSlotData();

  globalSnap.add(user);

  //snap.set(slotAttendance);
  //SetOptions(merge: true)
}
