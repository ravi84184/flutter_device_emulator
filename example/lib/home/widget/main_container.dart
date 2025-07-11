import 'package:flutter/material.dart';
import 'package:flutter_device_emulator_example/home/widget/announcement_widget.dart'
    show AnnouncementWidget;
import 'package:flutter_device_emulator_example/home/widget/header.dart';
import 'package:flutter_device_emulator_example/home/widget/recent_activity_widget.dart';
import 'package:flutter_device_emulator_example/home/widget/upcomming.dart';

class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffFFFFFF),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // header
          HeaderWidget(),
          Expanded(
            child: SingleChildScrollView(
              child: mainContentWidget(
                MediaQuery.of(context).size.width > 1320,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget mainContentWidget(bool isExpanded) {
    return Container(
      color: Color(0xffFFFFFF),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dashboard',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                responsiveWidget([
                  cardWidget(
                    'Available Position',
                    '24',
                    '4 Urgently needed',
                    Color(0xffFF5151),
                  ),
                  cardWidget(
                    'Job Open',
                    '10',
                    '4 Active hiring',
                    Color(0xff3786F1),
                  ),
                  cardWidget(
                    'New Employees',
                    '24',
                    '4 Department',
                    Color(0xffEE61CF),
                  ),
                ], MediaQuery.of(context).size.width > 700),
                SizedBox(height: 30),
                responsiveWidget([
                  chartWidget(
                    title: 'Total Employees',
                    value: '100',
                    growth: '10%',
                    manNumber: '50',
                    womanNumber: '50',
                  ),
                  chartWidget(
                    title: 'Talent Request',
                    value: '100',
                    growth: '10%',
                    manNumber: '50',
                    womanNumber: '50',
                  ),
                ], MediaQuery.of(context).size.width > 700),
                SizedBox(height: 30),
                AnnouncementWidget(),
                if (!isExpanded) ...[
                  SizedBox(height: 30),
                  rightContentWidget(),
                ],
              ],
            ),
          ),
          if (isExpanded) ...[
            SizedBox(width: 20),
            Expanded(child: rightContentWidget()),
          ],
        ],
      ),
    );
  }

  Widget responsiveWidget(List<Widget> children, bool isExpanded) {
    if (isExpanded) {
      return Row(
        spacing: 15,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children.map((e) => Expanded(child: e)).toList(),
      );
    } else {
      return Column(
        spacing: 15,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      );
    }
  }

  Widget rightContentWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RecentActivityWidget(),
        SizedBox(height: 20),
        UpcommingWidget(),
      ],
    );
  }

  Widget chartWidget({
    required String title,
    required String value,
    String? growth,
    String? manNumber,
    String? womanNumber,
  }) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xffE0E0E0)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  '${manNumber ?? ''} Male',
                  style: TextStyle(color: Color(0xff686868)),
                ),
                Text(
                  '${womanNumber ?? ''} Female',
                  style: TextStyle(color: Color(0xff686868)),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffFFEFE7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    '${growth ?? ''} Past month',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardWidget(String title, String value, String note, Color color) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.black)),
          SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(note, style: TextStyle(color: color)),
        ],
      ),
    );
  }
}
