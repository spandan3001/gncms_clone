import 'dart:async';

import 'package:flutter/material.dart';
import 'list_creation.dart';
import 'constants.dart';

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
  var time = DateTime.now();
  var weekday = 0;
  late Timer timer;

  void checkDate() {
    setState(() {
      time = DateTime.now();
      weekday = time.weekday;
      weekday -= 1;
      date = kDays[weekday];
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
    tabController =
        TabController(length: 7, vsync: this, initialIndex: (weekday));
    startCountdown();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    tabController.dispose();
    super.dispose();
  }

  //return stuff

  @override
  Widget build(BuildContext context) {
    List<Widget> cardWidget = listObj.getCardWidget();
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
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  color: const Color(0xFF02BDEC),
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                      height: 30,
                      child: TabBar(
                        isScrollable: true,
                        unselectedLabelColor: Colors.white,
                        labelColor: Colors.black,
                        indicatorColor: Colors.white,
                        indicatorWeight: 2,
                        indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        controller: tabController,
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
                          Tab(
                            text: 'Sun',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child:
                  TabBarView(controller: tabController, children: cardWidget),
            ),
          ],
        ),
      ),
    );
  }
}
