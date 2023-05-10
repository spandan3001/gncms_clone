import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gncms_clone/initial_data.dart';
import 'package:gncms_clone/teacher/add_student.dart';
import 'package:gncms_clone/teacher/teacher_time_table_screen.dart';
import '../custom_widgets/profile_card.dart';
import '../custom_widgets/small_card.dart';
import '../student_home_screen.dart';
import '../user_login_in/screens/login_page.dart';

class TeacherHomeScreen extends StatelessWidget {
  const TeacherHomeScreen({Key? key}) : super(key: key);
  static const id = "/teacher/homeScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "SIR MVIT",
          style: TextStyle(color: Colors.white),
        ),
        //leading: Icon(Icons.man),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: PopupMenuButton(
              shadowColor: Colors.black,
              icon: const Icon(Icons.account_circle,
                  size: 40, color: Colors.grey),
              splashRadius: 20,
              itemBuilder: (context) => [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text('👤Profile'),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text('🌐Web Login'),
                ),
                const PopupMenuItem<int>(
                  value: 2,
                  child: Text('🔑Change Password'),
                ),
                const PopupMenuItem<int>(
                  value: 3,
                  child: Text('🔙 Logout'),
                ),
              ],
              onSelected: (item) => selectedItem(context, item),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height / 4.5),
              color: Colors.black,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "spandan M N",
                      style: TextStyle(
                          color: Colors.amber, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                      child: Row(
                        children: const [
                          Text(
                            'phoneNo',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          VerticalDivider(
                            indent: 1,
                            endIndent: 1,
                            color: Colors.grey,
                            width: 10,
                            thickness: 1,
                          ),
                          Text(
                            'email',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 20,
                      color: Colors.grey,
                      thickness: 0.7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        detailBlock(heading: "Department", value: "CS"),
                        detailBlock(
                            heading: "Designation",
                            value: "Assistance Professor"),
                        detailBlock(heading: "Emp Code", value: "EMP123"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 120),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisSpacing: 25,
                mainAxisSpacing: 25,
                crossAxisCount: 3,
                children: [
                  CardWidget(
                    icon: Icons.calendar_month,
                    cardName: 'Academic Calender',
                    onPressed: () {
                      //Navigator.pushNamed(context, );
                    },
                    iconColor: Colors.tealAccent,
                  ),
                  CardWidget(
                    icon: Icons.table_chart_outlined,
                    cardName: 'Timetable',
                    onPressed: () {
                      Navigator.pushNamed(context, TeacherTimeTableScreen.id);
                    },
                    iconColor: Colors.blueAccent,
                  ),
                  CardWidget(
                    icon: Icons.people,
                    cardName: 'Pending Attendance',
                    onPressed: () {
                      //Navigator.pushNamed(context, AttendanceScreen.id);
                    },
                    iconColor: Colors.deepPurple,
                  ),
                  CardWidget(
                    icon: Icons.newspaper,
                    cardName: 'Summary',
                    onPressed: () {},
                    iconColor: Colors.green,
                  ),
                  CardWidget(
                    icon: Icons.notification_important,
                    cardName: 'Notification',
                    onPressed: () {},
                    iconColor: Colors.grey,
                  ),
                  CardWidget(
                    icon: Icons.add,
                    cardName: 'Add Student',
                    onPressed: () {
                      Navigator.pushNamed(context, AddStudent.id);
                    },
                    iconColor: Colors.grey,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Column detailBlock({String heading = "", String value = ""}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: const TextStyle(color: Colors.grey, fontSize: 15),
        ),
        Text(
          value,
          style: const TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  selectedItem(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.pushNamed(context, ProfileCardScreen.id);
        break;
      case 3:
        Navigator.pop(context);
        FirebaseAuth.instance.signOut();
        Navigator.pushNamed(context, LoginScreen.id);
        InitialData.initGlobalData();
        break;
    }
  }
}
