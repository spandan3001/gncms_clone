import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gncms_clone/custom_widgets/tab_bar.dart';
import 'package:intl/intl.dart';
import 'list_creation.dart';

var listObj = ListCreation();

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({Key? key}) : super(key: key);
  static const id = '/timeTableScreen';

  @override
  TimeTableScreenState createState() => TimeTableScreenState();
}

class TimeTableScreenState extends State<TimeTableScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  String date = '';
  var currentDate = DateTime.now();
  var weekday = 0;
  late Timer timer;

  void checkDate() {
    setState(() {
      currentDate = DateTime.now();
      weekday = currentDate.weekday;
      weekday -= 1;
      date = DateFormat('EEEE').format(currentDate);
      tabController.animateTo(weekday);
    });
  }

  void startCountdown() {
    checkDate();
    listObj.checkTimeSlot();

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        listObj.checkTimeSlot();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: 6, vsync: this, initialIndex: (weekday));
    startCountdown();
  }

  @override
  void dispose() {
    timer.cancel();
    tabController.dispose();
    super.dispose();
  }

  List<Widget> getTimeTable() {
    Map<String, Widget> cardWidget = listObj.createCardWidget();
    return cardWidget.values.toList();
  }

  //return stuff

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'CS 6B B2',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      checkDate();
                    },
                    child: Text(
                      "Today : $date",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            CustomTabBar(
                tabController: tabController,
                tabs: const [
                  Tab(
                    text: 'Mon',
                  ),
                  Tab(
                    text: 'Tue',
                  ),
                  Tab(
                    text: 'Wed',
                  ),
                  Tab(
                    text: 'thu',
                  ),
                  Tab(
                    text: 'Fri',
                  ),
                  Tab(
                    text: 'Sat',
                  ),
                ],
                onTap: (value) {}),
            Expanded(
              child: TabBarView(
                  controller: tabController, children: getTimeTable()),
            ),
          ],
        ),
      ),
    );
  }
}
