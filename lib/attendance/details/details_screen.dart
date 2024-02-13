import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gncms_clone/attendance/details/day_wise.dart';
import 'package:gncms_clone/attendance/details/subject_wise.dart';
import 'package:gncms_clone/custom_widgets/tab_bar.dart';
import 'package:gncms_clone/getX/values/app_colors.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.keyboard_return,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Attendance Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.darkestBlue,
      ),
      body: Column(
        children: [
          CustomTabBar(
            onTap: (value) {},
            tabController: _tabController,
            tabs: const [
              Tab(
                text: "Subject Wise",
              ),
              Tab(
                text: "Day Wise",
              )
            ],
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: const [
              SubjectWiseDetails(),
              DayWiseDetails(),
            ]),
          ),
        ],
      ),
    );
  }
}
