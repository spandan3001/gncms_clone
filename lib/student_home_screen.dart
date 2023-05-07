import 'package:firebase_auth/firebase_auth.dart';
import 'package:gncms_clone/academic_calender/calendar_screen.dart';
import 'package:gncms_clone/attendance/attendance_screen.dart';
import 'package:gncms_clone/fees/fees_screen.dart';
import 'package:gncms_clone/initial_data.dart';
import 'package:gncms_clone/custom_widgets/profile_card.dart';
import 'package:gncms_clone/custom_widgets/small_card.dart';
import 'package:flutter/material.dart';
import 'package:gncms_clone/time_table/time_table_screen.dart';
import 'package:gncms_clone/user_login_in/screens/login_page.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({Key? key}) : super(key: key);

  static const id = '/HomeScreen';

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  height: (MediaQuery.of(context).size.height / 4),
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${globalData['firstName']} ${globalData['lastName']}",
                          style: const TextStyle(
                              color: Colors.amber, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "($globalUserId)",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        SizedBox(
                          height: 15,
                          child: Row(
                            children: [
                              Text(
                                globalData['phoneNo'],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                              const VerticalDivider(
                                indent: 1,
                                endIndent: 1,
                                color: Colors.grey,
                                width: 10,
                                thickness: 1,
                              ),
                              Text(
                                globalData['email'],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 10,
                          color: Colors.grey,
                          thickness: 0.7,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Branch",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    "CS",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Sem",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    "6",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Division",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    "CS-6-B-2023 ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Roll NO.",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    "66",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Batch",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    "2",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 130),
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
                        Navigator.pushNamed(context, HomeCalendarScreen.id);
                      },
                      iconColor: Colors.blue,
                    ),
                    CardWidget(
                      icon: Icons.timelapse,
                      cardName: 'Timetable',
                      onPressed: () {
                        Navigator.pushNamed(context, TimeTableScreen.id);
                      },
                      iconColor: Colors.blueAccent,
                    ),
                    CardWidget(
                      icon: Icons.people,
                      cardName: 'Attendance',
                      onPressed: () {
                        Navigator.pushNamed(context, AttendanceScreen.id);
                      },
                      iconColor: Colors.deepPurple,
                    ),
                    CardWidget(
                      icon: Icons.book,
                      cardName: 'LMS',
                      onPressed: () {},
                      iconColor: Colors.red,
                    ),
                    CardWidget(
                      icon: Icons.padding_sharp,
                      cardName: 'Internal Assessment',
                      onPressed: () {},
                      iconColor: Colors.red,
                    ),
                    CardWidget(
                      icon: Icons.credit_card,
                      cardName: 'Fees',
                      onPressed: () {
                        Navigator.pushNamed(context, FeeScreen.id);
                      },
                      iconColor: Colors.green,
                    ),
                    CardWidget(
                      icon: Icons.bus_alert_outlined,
                      cardName: 'Transport',
                      onPressed: () {},
                      iconColor: Colors.orange,
                    ),
                    CardWidget(
                      icon: Icons.notification_important,
                      cardName: 'Notification',
                      onPressed: () {},
                      iconColor: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
        globalEmail = "";
        globalCurrentUser = "";
        globalUserId = "";
        break;
    }
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    final path = Path();

    path.lineTo(0, height - 40);
    path.quadraticBezierTo(width / 2, height + 40, width, height - 40);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
