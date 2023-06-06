import 'package:flutter/material.dart';
import '../constants.dart';

class TCardWidget extends StatelessWidget {
  final String typeText;
  final String time;
  final String subject;
  final String teacherName;
  final bool isActive;

  const TCardWidget(
      {Key? key,
      required this.time,
      required this.typeText,
      required this.subject,
      required this.teacherName,
      required this.isActive})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 3),
      child: Material(
        color: isActive ? Colors.blue : Colors.white,
        shadowColor: Theme.of(context).colorScheme.shadow,
        surfaceTintColor: Theme.of(context).colorScheme.primary,
        elevation: 5.0,
        borderRadius: const BorderRadius.all(Radius.circular(2.0)),
        type: MaterialType.card,
        child: SizedBox(
            height: isActive ? 130 : 100,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            time.substring(0, 5),
                            style: kTimeStyle,
                          ),
                          const Text(
                            'to',
                            style: kTimeStyle,
                          ),
                          Text(
                            time.substring(6),
                            style: kTimeStyle,
                          ),
                        ]),
                  ),
                  const VerticalDivider(
                    color: Color(0xFFE8E8E8),
                    width: 40.0,
                    thickness: 1.5,
                  ),
                  Expanded(
                    child: Padding(
                      padding: isActive
                          ? const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 10.0)
                          : const EdgeInsets.all(0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            Text(
                              subject,
                              style: const TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              teacherName,
                              style: const TextStyle(
                                fontSize: 8.0,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
