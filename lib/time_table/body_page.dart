import 'package:flutter/material.dart';

class BodyPage extends StatefulWidget {
  const BodyPage({super.key,required this.cardWidget});

  final List<Widget> cardWidget;
  @override
  State<BodyPage> createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE8E8E8),
            borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:widget.cardWidget,
        ),
      ),
    );
  }
}