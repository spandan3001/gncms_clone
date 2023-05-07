import 'package:flutter/material.dart';
import 'package:gncms_clone/attendance/details/day_wise_display_widget.dart';

class DayWiseDetails extends StatelessWidget {
  const DayWiseDetails({Key? key}) : super(key: key);

  static const id = '/attendance/details/day_wise';

  TableRow buildRow({required List<String> children , isHeader}) {
    List<Widget> newTableChildren = [
      isHeader ? const Center(child: Text('Date')) : const Center(child: Text('18-Apr')),
    ];
    for (var element in children) {
      newTableChildren.add(Padding(
        padding: isHeader
            ? const EdgeInsets.all(5)
            : const EdgeInsets.all(0),
        child: Center(
          child: isHeader
              ? Text(
            element,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 10),
          )
              : TextDetailButton(
            text: element,
          ),
        ),
      ),
      );
    }
    TableRow newTableRow= TableRow(
        children: newTableChildren
    );
    return newTableRow;
  }

  List<String> slots() {
    List<String> slots = [];

    for(var i = 0; i < 9; i++) {
      slots.add('Slot ${i + 1}');
    }
    return slots;
  }

  List<String> cells() {
    List<String> cell = [];

    for (var i = 0; i < 9; i++) {
      if(i%2 == 0) {
        cell.add('P');
      } else {
        cell.add('A');
      }
    }
    return cell;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
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
          Table(
            border: TableBorder.all(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FractionColumnWidth(0.2),
            },
            children: [
              buildRow(children: slots(), isHeader: true),
              buildRow(children: cells(), isHeader: false),
              buildRow(children: cells(), isHeader: false),
              buildRow(children: cells(), isHeader: false),
            ],
          ),
        ],
      ),
    );
  }
}
