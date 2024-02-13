import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gncms_clone/getX/controllers/main_controller.dart';
import 'package:gncms_clone/getX/controllers/user_controllers/teacher_user_controller.dart';
import 'package:gncms_clone/getX/values/app_colors.dart';
import 'package:gncms_clone/main.dart';
import 'package:gncms_clone/teacher/teacher_time_table_screen.dart';
import '../../custom_widgets/profile_card.dart';
import '../../custom_widgets/small_card.dart';
import '../data/model/timetable_model.dart';
import '../route/app_routes.dart';
import 'student_home_screen.dart';

class TeacherHomeScreen extends StatelessWidget {
  const TeacherHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mainController = Get.find<MainController>();
    final userController = Get.find<TeacherController>();
    final userModel = userController.getUser();
    var size = MediaQuery.sizeOf(context);
    var scale = (size.height / size.width) * 0.5;
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              height: (size.height * 0.3) * scale,
              color: AppColors.darkestBlue,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 8 * scale, vertical: 20 * scale),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "SIR MVIT",
                          style: TextStyle(color: Colors.white, fontSize: 30),
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
                      userModel?.firstName ?? "xxx",
                      style: const TextStyle(
                          color: Colors.amber, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                      child: Row(
                        children: [
                          Text(
                            userModel?.phoneNo ?? 'phoneNo',
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
                            userModel?.email ?? 'email',
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
                        detailBlock(
                            heading: "Department",
                            value: userModel?.branch.toUpperCase() ?? "XX"),
                        detailBlock(
                            heading: "Designation",
                            value: "Assistance Professor"),
                        detailBlock(
                            heading: "Emp Code",
                            value: userModel?.tId ?? "123xx"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 8.0, top: (size.height * 0.22) * scale, right: 8.0),
            child: GridView.count(
              crossAxisSpacing: 25,
              mainAxisSpacing: 25,
              crossAxisCount: 3,
              children: [
                CardWidget(
                  icon: Icons.calendar_month,
                  cardName: 'Academic Calender',
                  onPressed: () async {
                    final query =
                        await mainController.firestoreController.testGc();

                    print(query.size);

                    //print("${query.docs.length} hello");
                    //print("${query.docs.first.data()} hello");
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
                  onPressed: () async {
                    await userController.getListOfTimetableModel();
                    Get.toNamed(AppRoutes.getClassListScreen);
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
              ],
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
