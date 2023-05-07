import 'package:flutter/material.dart';
import 'package:gncms_clone/initial_data.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton(
      {Key? key,
      required this.character,
      required this.title,
      required this.value,
      required this.onChanged})
      : super(key: key);

  final SingingCharacter? character;
  final SingingCharacter value;
  final String title;
  final Function(SingingCharacter?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: RadioListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
