import 'package:flutter/material.dart';
import 'package:gncms_clone/time_table/constants.dart';

class TextDetailButton extends StatefulWidget {
  const TextDetailButton(
      {Key? key,
      required this.text,
      required this.dateTime,
      required this.subject,
      required this.presentAbsentPending})
      : super(key: key);

  final String text;
  final DateTime dateTime;
  final String subject;
  final String presentAbsentPending;

  @override
  State<TextDetailButton> createState() => _TextDetailButtonState();
}

class _TextDetailButtonState extends State<TextDetailButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.text == 'A' ? Colors.red.shade50 : Colors.green.shade50,
      width: 30,
      height: 40,
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(
              widget.text == 'A' ? Colors.red.shade100 : Colors.green.shade100),
        ),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  margin: const EdgeInsets.all(20),
                  height: (MediaQuery.of(context).size.height / 100) * 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                        child: Row(
                          children: [
                            Container(
                              color: Colors.red.shade50,
                              //margin: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    size: 15,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      widget.dateTime
                                          .toString()
                                          .substring(0, 10),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            const VerticalDivider(
                              endIndent: 5,
                              indent: 5,
                              thickness: 1,
                              width: 10,
                              color: Colors.black,
                            ),
                            const Text(
                              "9:00 AM to 9:55 AM",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            const VerticalDivider(
                              endIndent: 5,
                              indent: 5,
                              thickness: 1,
                              width: 10,
                              color: Colors.black,
                            ),
                            Container(
                              height: 15.0,
                              width: 40.0,
                              color: kLectureBackColor,
                              child: const Center(
                                child: Text(
                                  'Lecture',
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold,
                                      color: kLectureColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.subject,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Mrs. Pragathi M',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 30.0,
                        width: 60.0,
                        color: widget.text == 'A'
                            ? kLabBackColor
                            : Colors.green.shade50,
                        child: Center(
                          child: Text(
                            widget.text == 'A' ? 'Absent' : 'Present',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: widget.text == 'A'
                                    ? kLabColor
                                    : Colors.green.shade500),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: widget.text == 'A' ? Colors.red : Colors.green),
          ),
        ),
      ),
    );
  }
}
