import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gncms_clone/academic_calender/calendar_screen.dart';
import 'package:gncms_clone/attendance/attendance_screen.dart';
import 'package:gncms_clone/fees/fees_screen.dart';
import 'package:gncms_clone/custom_widgets/profile_card.dart';
import 'package:gncms_clone/custom_widgets/small_card.dart';
import 'package:flutter/material.dart';
import 'package:gncms_clone/time_table/time_table_screen.dart';

import '../controllers/main_controller.dart';
import '../controllers/user_controllers/student_user_controller.dart';
import '../data/model/student_model.dart';
import '../route/app_routes.dart';
import '../values/app_colors.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<StudentController>();
    final StudentModel studentModel = userController.getUser();
    var size = MediaQuery.sizeOf(context);
    var scale = (size.height / size.width) * 0.5;
    print(size);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ClipPath(
              clipper: CustomClipPath(),
              child: Container(
                  height: (size.height * 0.3) * scale,
                  decoration: const BoxDecoration(
                      gradient:
                          LinearGradient(colors: AppColors.defaultGradient)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8 * scale),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "SIR MVIT",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                            PopupMenuButton(
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
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "${studentModel.firstName} ${studentModel.lastName}",
                          style: const TextStyle(
                              color: Colors.amber, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "(${studentModel.usn})",
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
                                studentModel.phoneNo ?? " ",
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
                                studentModel.email,
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
                                children: [
                                  const Text(
                                    "Branch",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    studentModel.branch.toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Sem",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    studentModel.semester.toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Division",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    "${studentModel.branch.toUpperCase()}-${studentModel.semester}-${studentModel.section.toUpperCase()}-2023",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Roll NO.",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    studentModel.usn.substring(7),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
              padding: EdgeInsets.only(
                  left: 8.0, top: (size.height * 0.25) * scale, right: 8.0),
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
                    onPressed: () async {
                      showDialog(
                        useRootNavigator: false,
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      );
                      NavigatorState state = Navigator.of(context);
                      //await globalObj.getAttendance();
                      //InitialData.globalUserAllTotalPercentage =
                      //evaluateAttendance();
                      state.pop();
                      state.pushNamed(AttendanceScreen.id);
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
          ],
        ),
      ),
    );
  }

  selectedItem(BuildContext context, int item) async {
    switch (item) {
      case 0:
        Navigator.pushNamed(context, ProfileCardScreen.id);
        break;
      case 3:
        final mainController = Get.find<MainController>();
        mainController.logOut();
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
