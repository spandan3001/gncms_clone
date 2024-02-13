import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final TextEditingController controller;
  final List<DropdownMenuItem<dynamic>>? items;
  final String hint;
  final String label;

  const CustomDropDown(
      {super.key,
      required this.controller,
      this.items,
      required this.hint,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton(
                value: controller.text,
                iconSize: 30,
                icon: (null),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                hint: Text(hint),
                items: items,
                onChanged: (value) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
