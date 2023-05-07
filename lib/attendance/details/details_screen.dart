import 'package:flutter/material.dart';
import 'package:gncms_clone/attendance/details/day_wise.dart';
import 'package:gncms_clone/attendance/details/subject_wise.dart';
import 'package:gncms_clone/custom_widgets/tab_bar.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  static const id = '/attendance/details';

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this, initialIndex: 0);
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
        title: const Text("Attendance Details"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          CustomTabBar(
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
