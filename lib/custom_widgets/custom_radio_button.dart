import 'package:flutter/material.dart';
import 'package:gncms_clone/initial_data.dart';

import '../constants.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton(
      {Key? key,
      required this.character,
      required this.title,
      required this.value,
      required this.onChanged})
      : super(key: key);

  final UserType? character;
  final UserType value;
  final String title;
  final Function(UserType?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: RadioListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          tileColor: Colors.blue.shade50,
          contentPadding: const EdgeInsets.all(0),
          title: Text(title),
          value: value,
          groupValue: character,
          activeColor: Colors.black,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
