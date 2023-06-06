import 'package:flutter/material.dart';
import '../constants.dart';

class TimeTableCard extends StatelessWidget {
  final String typeText;
  final dynamic time;
  final String subject;
  final String teacherName;

  const TimeTableCard({
    Key? key,
    required this.time,
    required this.typeText,
    required this.subject,
    required this.teacherName,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shadowColor: Theme.of(context).colorScheme.shadow,
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      elevation: 5.0,
      borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      type: MaterialType.card,
      child: SizedBox(
          height: 180,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 15.0,
                          width: 40.0,
                          color: typeText == 'Lab'
                              ? kLabBackColor
                              : kLectureBackColor,
                          child: Center(
                            child: Text(
                              typeText,
                              style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                  color: typeText == 'Lab'
                                      ? kLabColor
                                      : kLectureColor),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          time[0],
                          style: kTimeStyle,
                        ),
                        const Text(
                          'to',
                          style: kTimeStyle,
                        ),
                        Text(
                          time[1],
                          style: kTimeStyle,
                        ),
                      ]),
                ),
                const VerticalDivider(
                  indent: 0,
                  endIndent: 100,
                  color: Color(0xFFE8E8E8),
                  width: 40.0,
                  thickness: 1.5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subject,
                        style: const TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        teacherName,
                        style: const TextStyle(
                          fontSize: 10.0,
                        ),
                      ),
                      const Text(
                        "CSE - 6B",
                        style: TextStyle(
                          fontSize: 10.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 120,
                        height: 25,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("P:20"),
                            Text("A:1"),
                            Text("T:21")
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        decoration: const BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [Icon(Icons.add)],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
