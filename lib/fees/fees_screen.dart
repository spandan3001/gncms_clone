import 'package:flutter/material.dart';
import 'package:gncms_clone/fees/icon_animation_button.dart';

class FeeScreen extends StatelessWidget {
  const FeeScreen({Key? key}) : super(key: key);
  static const id = '/feeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fees"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)))),
                  onPressed: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Pay Fees",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            IconAnimationButton(
              onPressed: (){},
              text: 'Pending fess',
              content: '81,766',
              isScrollable: true,
              color: Colors.red.shade400,
            ),
            IconAnimationButton(
              onPressed: (){

              },
              text: 'Year - 3',
              content: '70,771',
              isScrollable: true,
              color: Colors.black38,
            ),
            IconAnimationButton(
              onPressed:(){

              },
              text: 'Total Fees Paid',
              content: '70,771',
              isScrollable: false,
              color: Colors.green.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
