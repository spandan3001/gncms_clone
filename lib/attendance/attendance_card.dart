import 'package:flutter/material.dart';

class AttendanceCard extends StatelessWidget {


  //final percentageAttendance;
  const AttendanceCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 5.0,
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        type: MaterialType.card,
        child: InkWell(
          onTap: () { Navigator.pushNamed(context, '/attendance/details'); },
          child: SizedBox(
            height: 60,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      height: 20.0,
                                      width: 50.0,
                                      color: Colors.black,
                                      child: const Center(
                                        child: Text(
                                          'Sem-6',
                                          style: TextStyle(
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    'A.Y.  ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    '2022-23',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const Text(
                                'Attendance',
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 30),
                          child: LinearProgressIndicator(
                            value: 0.72,
                            minHeight: 5,
                            backgroundColor: Color(0xFFEAFAF5),
                            valueColor: AlwaysStoppedAnimation(Color(0xFF07BD84)),
                          ),
                        ),
                      ),
                      Text("72.00%")
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
