import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class SnackBarHelper {
  const SnackBarHelper._();

  static final _key = GlobalKey<ScaffoldMessengerState>();

  static GlobalKey<ScaffoldMessengerState> get key => _key;

  static void showSnackBar(
          {String? title, String? message, ContentType? contentType}) =>
      _key.currentState
        ?..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: SizedBox(
              height: 100,
              child: AwesomeSnackbarContent(
                title: title ?? "",
                message: message ?? "",
                contentType: contentType ?? ContentType.help,
              ),
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
}
