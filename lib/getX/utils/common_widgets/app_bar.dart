import 'package:flutter/material.dart';
import 'package:gncms_clone/getX/utils/common_widgets/back_button.dart';

AppBar customAppBar(
    {required String title,
    Color color = Colors.black,
    void Function()? onPressed}) {
  return AppBar(
    title: Text(title),
    leading: CustomBackButton(
      onPressed: onPressed,
      color: color,
    ),
  );
}
