import 'package:flutter/material.dart';


const kTimeStyle = TextStyle(
    fontSize: 10.0,color: Color(0xFF5E5D5D));


const kLabColor = Color(0xFFF80202);
const kLabBackColor = Color(0x39F80202);


const kLectureColor = Color(0xFF02BDEC);
const kLectureBackColor = Color(0x3901DEFA);


const List<List<String>> kTime = [
  ['9:00 AM','9:55 AM'],
  ['9:55 AM','10:50 AM'],
  ['11:00 AM','11:55 AM'],
  ['11:55 AM','12:50 PM'],
  ['01:35 PM','04:20 PM']
];




const List<String> kDays= ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'] ;

const Map<String,Map<String,String>> kSubjects = {
  '61' : {'subject':'18CS61 - System Software and Compilers',
    'teacher' : 'Ms. Mayuri.K.P '
  },
  '62' : {'subject' : '18CS62 - Computer Graphics and Visualization',
    'teacher' : 'Pragathi'
  },
  '63' : {'subject' : '18CS63 - Web Technology and its Applications',
    'teacher' : 'Shobha'
  },
  '643' : {'subject' : '18CS643 - Cloud Computing and its Applications',
    'teacher' : 'Srinivas'
  },
  '652' : {'subject' : '18IM652 - Data Analytics and Economics',
    'teacher' : 'Mr. J.K'
  },
  'l67' : {'subject' : '18CSL67 - Computer Graphics Laboratory with Mini Project' ,
    'teacher' : 'pragathi'
  },
  'l66' : {'subject' : '18CSL66 - System Software Laboratory' ,
    'teacher' : 'Ms. Mayuri.K.P '
  },
  'mp68': {'subject' : '18CSMP68 - Mobile Application Development' ,
    'teacher' : 'Mrs. Kavya G.M.'
  },

'web': {'subject' : '18CSMP69 - Web Development' ,
'teacher' : 'Shobha'
},

  '0' : {'subject': 'No Class',
    'teacher' : ' '
  }
};



