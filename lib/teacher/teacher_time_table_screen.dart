import 'package:flutter/material.dart';
import 'package:gncms_clone/custom_widgets/tab_bar.dart';

import '../time_table/constants.dart';

class TeacherTimeTableScreen extends StatefulWidget {
  const TeacherTimeTableScreen({Key? key}) : super(key: key);
  static const id = '/teacherTimeTableScreen';

  @override
  State<TeacherTimeTableScreen> createState() => _TeacherTimeTableScreenState();
}

class _TeacherTimeTableScreenState extends State<TeacherTimeTableScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  String date = 'hello';
  var time = DateTime.now();
  var weekday = 0;

  void checkDate() {
    setState(() {
      time = DateTime.now();
      weekday = time.weekday;
      weekday = (weekday > 5 && weekday != 0) ? 4 : weekday - 1;
      date = "hello";
      tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    });
  }

  @override
  void initState() {
    checkDate();
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Time Table"),
                Text(
                  'By Spandan',
                  style: TextStyle(fontSize: 8),
                )
              ])),
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'CSE 6B B2',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      checkDate();
                    },
                    child: SizedBox(
                      height: 30,
                      width: 150,
                      child: Center(
                        child: Text(
                          "Today : $date",
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            CustomTabBar(
              tabController: tabController,
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
              child: TabBarView(controller: tabController, children: const [
                Text("Hello"),
                Text("Hello"),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
