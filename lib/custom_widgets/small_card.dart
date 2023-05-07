import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final IconData icon;
  final String cardName;
  final VoidCallback onPressed;
  final Color iconColor;

  const CardWidget(
      {Key? key,
      required this.icon,
      required this.cardName,
      required this.onPressed,
      required this.iconColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      elevation: 5.0,
      child: InkWell(
        radius: 30,
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                size: 40,
                color: iconColor,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: cardName,
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
