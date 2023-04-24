import 'package:gncms_clone/initial_data.dart';
import 'package:gncms_clone/small_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  @override
  void initState() {
    super.initState();
    runMate();

    setState(() {
      data;
    });
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "SIR MVIT",
            style: TextStyle(color: Colors.white),
          ),
          //leading: Icon(Icons.man),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: PopupMenuButton(
                shadowColor: Colors.black,
                icon: const Icon(Icons.account_circle,size: 40,color:Colors.grey),
                splashRadius: 20,
                itemBuilder: (context) => [
                  const PopupMenuItem<int>(
                    value: 0,
                    child: Text('👤Profile'),
                  ),
                  const PopupMenuItem<int>(
                    value: 1,
                    child: Text('🌐Web Login'),
                  ),
                  const PopupMenuItem<int>(
                    value: 2,
                    child: Text('🔑Change Password'),
                  ),
                  const PopupMenuItem<int>(
                    value: 3,
                    child: Text('🔙 Logout'),
                  ),
                ],
                onSelected: (item)=> selectedItem(context,item),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            ClipPath(
              clipper: CustomClipPath(),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: (MediaQuery.of(context).size.height / 4),
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${data['firstName']} ${data['lastName']}",
                          style: const TextStyle(
                              color: Colors.amber, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "($usn)",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        SizedBox(
                          height: 15,
                          child: Row(
                            children: [
                              Text(
                                data['phoneNo'] ?? " ",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                              const VerticalDivider(
                                indent: 1,
                                endIndent: 1,
                                color: Colors.grey,
                                width: 10,
                                thickness: 1,
                              ),
                              Text(
                                data['email'] ?? " ",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 10,
                          color: Colors.grey,
                          thickness: 0.7,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Branch",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    "CS",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Sem",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    "6",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Division",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    "CS-6-B-2023 ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Roll NO.",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    "66",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Batch",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    "2",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 150),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 25,
                  crossAxisCount: 3,
                  children: [
                    CardWidget(
                      icon: Icons.calendar_month,
                      cardName: 'Academic Calender',
                      onPressed: () {
                        Navigator.pushNamed(context, '/timeTable');
                      },
                      iconColor: Colors.blue,
                    ),
                    CardWidget(
                      icon: Icons.timelapse,
                      cardName: 'Timetable',
                      onPressed: () {
                        Navigator.pushNamed(context, '/timeTable');
                      },
                      iconColor: Colors.blueAccent,
                    ),
                    CardWidget(
                      icon: Icons.people,
                      cardName: 'Attendance',
                      onPressed: () {
                        Navigator.pushNamed(context, '/attendanceScreen');
                      },
                      iconColor: Colors.deepPurple,
                    ),
                    CardWidget(
                      icon: Icons.book,
                      cardName: 'LMS',
                      onPressed: () {},
                      iconColor: Colors.red,
                    ),
                    CardWidget(
                      icon: Icons.padding_sharp,
                      cardName: 'Internal Assessment',
                      onPressed: () {},
                      iconColor: Colors.red,
                    ),
                    CardWidget(
                      icon: Icons.credit_card,
                      cardName: 'Fees',
                      onPressed: () {
                        Navigator.pushNamed(context, '/fees');
                      },
                      iconColor: Colors.green,
                    ),
                    CardWidget(
                      icon: Icons.bus_alert_outlined,
                      cardName: 'Transport',
                      onPressed: () {},
                      iconColor: Colors.orange,
                    ),
                    CardWidget(
                      icon: Icons.notification_important,
                      cardName: 'Notification',
                      onPressed: () {},
                      iconColor: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  selectedItem(BuildContext context, int item) {
    switch(item){

      case 0: Navigator.pushNamed(context,'/profile');
      break;


    }

  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;

    final path = Path();

    path.lineTo(0, height - 40);
    path.quadraticBezierTo(width / 2, height + 40, width, height - 40);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
