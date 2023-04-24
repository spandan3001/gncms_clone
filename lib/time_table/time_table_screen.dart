import 'package:flutter/material.dart';



class TimeTableScreen extends StatelessWidget {
  const TimeTableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(
      child:  Scaffold(
        body: Center(
            child : Text(
                "Time Table"
            )
        ),
      ),
    );
  }
}