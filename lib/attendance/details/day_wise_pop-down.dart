import 'package:flutter/material.dart';

Map<String, dynamic> details = {
  'absent': {
    'symbol': 'A',
    'textColor': Colors.red,
    'backgroundColor': Colors.red.shade200,
  },
  'present': {
    'symbol': 'P',
    'textColor': Colors.green,
    'backgroundColor': Colors.lightGreen.shade200
  },
  'pending': {
    'symbol': 'PN',
    'textColor': Colors.yellow,
    'backgroundColor': Colors.yellow.shade200,
  },
};

class TextDetailButton extends StatefulWidget {
  const TextDetailButton(
      {Key? key,
      required this.dateTime,
      required this.subject,
      required this.timeSlot,
      required this.teacherName,
      required this.slotDetailKey})
      : super(key: key);

  final String slotDetailKey;
  final DateTime dateTime;
  final String subject;
  final String timeSlot;
  final String teacherName;

  @override
  State<TextDetailButton> createState() => _TextDetailButtonState();
}

class _TextDetailButtonState extends State<TextDetailButton> {
  dynamic getDetails(String key) {
    return details[widget.slotDetailKey][key];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: getDetails('backgroundColor'),
      width: 30,
      height: 30,
      child: TextButton(
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
                              color: getDetails('backgroundColor'),
                              child: Center(
                                child: Text(
                                  'Lecture',
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold,
                                      color: getDetails('textColor')),
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
                        color: getDetails('backgroundColor'),
                        child: Center(
                          child: Text(
                            widget.slotDetailKey,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: getDetails('textColor'),
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
            getDetails('symbol'),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: getDetails('textColor'),
            ),
          ),
        ),
      ),
    );
  }
}
