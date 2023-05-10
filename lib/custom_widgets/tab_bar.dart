import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar(
      {Key? key, required this.tabController, required this.tabs})
      : super(key: key);

  final TabController tabController;
  final List<Tab> tabs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height / 100) * 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: const BoxDecoration(
        color: Color(0xFF02BDEC),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5), topRight: Radius.circular(5)),
      ),
      child: TabBar(
        isScrollable: true,
        unselectedLabelColor: Colors.white,
        labelColor: Colors.black,
        indicatorWeight: 2,
        indicator: BoxDecoration(
          color: Colors.blue.withOpacity(0.5),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5)),
        ),
        controller: tabController,
        tabs: tabs,
      ),
    );
  }
}
