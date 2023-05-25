import 'package:flutter/material.dart';
import 'package:gncms_clone/initial_data.dart';

class DayWiseDetails extends StatefulWidget {
  const DayWiseDetails({Key? key}) : super(key: key);

  static const id = '/attendance/details/day_wise';

  @override
  State<DayWiseDetails> createState() => _DayWiseDetailsState();
}

class _DayWiseDetailsState extends State<DayWiseDetails>
    with AutomaticKeepAliveClientMixin {
  bool flagForScreenDisplay = false;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => executeAfterBuild());
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('P = Present,'),
              Text('A = Absent,'),
              Text('- = No Lecture/Lab,'),
              Text('PN = Pending'),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 100,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: const Icon(Icons.add),
                  title: Text('Person $index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> executeAfterBuild() async {
    flagForScreenDisplay = true;
    setState(() {});
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
