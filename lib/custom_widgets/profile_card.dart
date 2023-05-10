import 'package:flutter/material.dart';
import 'package:gncms_clone/initial_data.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileCardScreen extends StatefulWidget {
  const ProfileCardScreen({Key? key}) : super(key: key);
  static const id = '/profileCardScreen';

  @override
  State<ProfileCardScreen> createState() => _ProfileCardScreenState();
}

class _ProfileCardScreenState extends State<ProfileCardScreen> {
  late double _detailButtonWidth = 20.0;
  String usn = '1MV20CS136';

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _detailButtonWidth = MediaQuery.of(context).size.width - 30;
    //print((MediaQuery.of(context).size.height*80)/100);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("profile"),
      ),
      body: Consumer<InitialData>(
        builder: (context, dataClass, child) => SingleChildScrollView(
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Column(
                children: [
                  Container(
                    height: (MediaQuery.of(context).size.height * 20) / 100,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: (MediaQuery.of(context).size.height * 12) / 100,
                    ),
                    child: Column(
                      children: [
                        studentDetail(Icons.phone, 'Student Number',
                            InitialData.globalData['phoneNo']),
                        studentDetail(Icons.email, 'Student Email',
                            InitialData.globalData['email']),
                        studentDetail(Icons.phone, 'Father Number',
                            InitialData.globalData['fatherPhoneNo']),
                        studentDetail(Icons.email, 'Father Email',
                            InitialData.globalData['fatherEmail']),
                        studentDetail(Icons.phone, 'Mother Number',
                            InitialData.globalData['motherPhoneNo']),
                        studentDetail(Icons.email, 'Father Email',
                            InitialData.globalData['motherEmail']),
                        studentDetail(Icons.phone, 'Guardian Number',
                            InitialData.globalData['guardianPhoneNo']),
                        studentDetail(Icons.email, 'Guardian Email',
                            InitialData.globalData['guardianEmail']),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Material(
                  elevation: 5.0,
                  color: Colors.white,
                  type: MaterialType.card,
                  borderRadius: BorderRadius.circular(5.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    height: (MediaQuery.of(context).size.height * 25) / 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          child: CircleAvatar(
                            radius: 36,
                            backgroundColor: Colors.grey,
                            child: Icon(
                              Icons.person_2,
                              size: 50,
                              color: Colors.black38,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${InitialData.globalData['firstName']} ${InitialData.globalData['lastName']}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "(${InitialData.globalUserId})",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Branch",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                        Text(
                                          "CS",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Sem",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                        Text(
                                          "6",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Division",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                        Text(
                                          "CS-6-B-2023 ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Roll NO.",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                        Text(
                                          "66",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Batch",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                        Text(
                                          "2",
                                          style: TextStyle(
                                              color: Colors.black,
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column studentDetail(
    IconData icon,
    String header,
    String value,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(header),
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue.shade200),
            fixedSize: MaterialStateProperty.all(Size(_detailButtonWidth, 40)),
            shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          ),
          onPressed: () async {
            if (icon == Icons.phone) {
              Uri url = Uri(scheme: 'tel', path: value);
              await launchUrl(url);
            } else {
              Uri url = Uri(scheme: 'mailto', path: value);
              await launchUrl(url);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    value,
                    style: const TextStyle(color: Colors.black),
                  )
                ],
              ),
              const Icon(Icons.keyboard_arrow_right, color: Colors.black),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
