import 'package:flutter/material.dart';
import 'package:flutter_device_emulator_example/home/widget/main_container.dart';

import 'widget/sidebar.dart' show Sidebar;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isExpanded = false;

  void toggleSidebar() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //sidebar
          if (MediaQuery.of(context).size.width > 700)
            Sidebar(isExpanded: MediaQuery.of(context).size.width > 1320),

          //main content
          Expanded(child: MainContainer()),
        ],
      ),
    );
  }
}
