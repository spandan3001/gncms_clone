import 'package:flutter/material.dart';
import 'package:gncms_clone/custom_widgets/tab_bar.dart';
import 'package:gncms_clone/teacher/time_table_card.dart';
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
      weekday = weekday - 1;
      date = kDays[weekday];
      tabController.animateTo(weekday);
    });
  }

  @override
  void initState() {
    tabController = TabController(length: 8, vsync: this, initialIndex: 0);
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
          backgroundColor: Colors.black, title: const Text("Time Table")),
      backgroundColor: Colors.grey.shade200,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(5),
              child: SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: InkWell(
                        onTap: () {},
                        child: const Icon(Icons.chevron_left),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: InkWell(
                        onTap: () {},
                        child: const Center(
                          child: Text(
                            "(20-11-2022 - 27-11-2022)",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: InkWell(
                        onTap: () {},
                        child: const Icon(Icons.chevron_right),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              checkDate();
            },
            child: Text(
              "Today : $date",
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          CustomTabBar(
            tabController: tabController,
            tabs: const [
              Tab(
                text: "Mon",
              ),
              Tab(
                text: "tue",
              ),
              Tab(
                text: "wed",
              ),
              Tab(
                text: "thu",
              ),
              Tab(
                text: "fri",
              ),
              Tab(
                text: "sat",
              ),
              Tab(
                text: "sun",
              ),
            ],
          ),
          Expanded(
            child: TabBarView(controller: tabController, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TimeTableCard(
                      time: kTime[0],
                      typeText: 'Lecture',
                      subject: kSubjects['61']!['subject']!,
                      teacherName: kSubjects['61']!['teacher']!,
                    )
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}