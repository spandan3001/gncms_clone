import 'package:flutter/material.dart';
import 'package:gncms_clone/attendance/details/day_wise.dart';
import 'package:gncms_clone/attendance/details/subject_wise.dart';

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
          Container(
            height: (MediaQuery.of(context).size.height/100)*5,
            margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            decoration: const BoxDecoration(
              color: Color(0xFF02BDEC),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5)),
            ),
            child: TabBar(
                unselectedLabelColor: Colors.white,
                labelColor: Colors.black,
                indicatorWeight: 2,
                indicator: BoxDecoration(
                  color: Colors.blue.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                ),
                controller: _tabController,
                tabs: const [
                  Tab(
                    text: "Subject Wise",
                  ),
                  Tab(
                    text: "Day Wise",
                  )
                ],
              ),
            ),
          Expanded(
            child:
            TabBarView(controller: _tabController, children: [
              SubjectWiseDetails(),
              DayWiseDetails(),

            ]),
          ),
        ],
      ),
    );
  }
}
