import 'package:flutter/material.dart';

class SubjectWiseDetails extends StatelessWidget {
  const SubjectWiseDetails({Key? key}) : super(key: key);

  TableRow buildRow({required List<String> children, isHeader}) => TableRow(
        decoration: isHeader
            ? const BoxDecoration(color: Colors.black12)
            : const BoxDecoration(),
        children: children
            .map(
              (cell) => Padding(
                padding: const EdgeInsets.all(5),
                child: Center(
                  child: Text(
                    cell,
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
            .toList(),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
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
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Table(
            border: TableBorder.all(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FractionColumnWidth(0.5),
              1: FractionColumnWidth(0.15),
              2: FractionColumnWidth(0.15),
            },
            children: [
              buildRow(
                  children: ['Course', 'Total', 'Present', 'Attendance'],
                  isHeader: true),
              buildRow(children: [
                '18CS61 - System Software and Compilers',
                '11',
                '7',
                '63.77%'
              ], isHeader: false),
              buildRow(children: [
                '18CS62 - Computer Graphics and Visualization',
                '13',
                '7',
                '63.77%'
              ], isHeader: false),
              buildRow(children: [
                '18CS63 - Web Technology and its Applications',
                '13',
                '7',
                '63.77%'
              ], isHeader: false),
              buildRow(children: [
                '18CS643 - Cloud Computing and its Applications',
                '13',
                '7',
                '63.77%'
              ], isHeader: false),
              buildRow(children: [
                '18IM652 - Data Analytics and Economics',
                '13',
                '7',
                '63.77%'
              ], isHeader: false),
              buildRow(children: [
                '18CSL67 - Computer Graphics Laboratory with Mini Project',
                '13',
                '7',
                '63.77%'
              ], isHeader: false),
              buildRow(children: [
                '18CSL66 - System Software Laboratory',
                '13',
                '7',
                '63.77%'
              ], isHeader: false),
              buildRow(children: [
                '18CSMP68 - Mobile Application Development',
                '13',
                '7',
                '63.77%'
              ], isHeader: false),
              buildRow(children: [
                '18CSMP69 - Web Technology Laboratory',
                '13',
                '7',
                '63.77%'
              ], isHeader: false),
            ],
          )
        ],
      ),
    );
  }
}
