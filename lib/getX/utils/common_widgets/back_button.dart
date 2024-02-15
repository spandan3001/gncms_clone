import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final Color color;
  final void Function()? onPressed;

  const CustomBackButton({
    Key? key,
    this.color = Colors.black,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: color,
      ),
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          Navigator.of(context).pop();
        }
      },
    );
  }
}
