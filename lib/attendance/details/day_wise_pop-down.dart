import 'package:flutter/material.dart';
import 'package:gncms_clone/constants.dart';

class TextDetailButton extends StatefulWidget {
  const TextDetailButton(
      {Key? key,
      required this.dateTime,
      required this.subject,
      required this.timeSlot,
      required this.teacherName,
      required this.slotDetails})
      : super(key: key);

  final Map<String, dynamic> slotDetails;
  final DateTime dateTime;
  final String subject;
  final String timeSlot;
  final String teacherName;

  @override
  State<TextDetailButton> createState() => _TextDetailButtonState();
}

class _TextDetailButtonState extends State<TextDetailButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: widget.slotDetails['color'],
      width: 30,
      height: 30,
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(
            widget.slotDetails['backgroundColor'],
          ),
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
                            Text(
                              widget.timeSlot,
                              style: const TextStyle(
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
                      Text(
                        widget.teacherName,
                        style: const TextStyle(
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
                        color: widget.slotDetails['color'],
                        child: Center(
                          child: Text(
                            widget.slotDetails['symbol'] == 'A'
                                ? 'Absent'
                                : 'Present',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: widget.slotDetails['color'],
                            ),
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
            widget.slotDetails['symbol'],
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: widget.slotDetails['color'],
            ),
          ),
        ),
      ),
    );
  }
}
