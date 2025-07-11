import 'package:flutter/material.dart';
import 'package:flutter_device_emulator_example/generated/assets.dart';

class Sidebar extends StatelessWidget {
  final bool isExpanded;
  const Sidebar({super.key, this.isExpanded = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF1F1F1),
      height: double.infinity,
      width: isExpanded ? 200 : 100,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            isExpanded ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          SizedBox(height: 25),
          Center(
            child: Text(
              "WeHR",
              style: TextStyle(
                fontSize: isExpanded ? 24 : 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff000000),
              ),
            ),
          ),
          SizedBox(height: 25),
          Text(
            'MAIN MENU',
            style: TextStyle(
              fontSize: isExpanded ? 12 : 10,
              fontWeight: FontWeight.bold,
              color: Color(0xff686868),
            ),
          ),
          _buildSidebarItem(
            'Dashboard',
            AppAssets.imageIcDashboardPng,
            isActive: true,
          ),
          _buildSidebarItem('Recruitment', AppAssets.imageIcRecruitmentPng),
          _buildSidebarItem('Schedule', AppAssets.imageIcCalendarPng),
          _buildSidebarItem('Employee', AppAssets.imageIcEmployeePng),
          _buildSidebarItem('Department', AppAssets.imageIcDepartmentPng),
          SizedBox(height: 50),
          Text(
            'OTHER',
            style: TextStyle(
              fontSize: isExpanded ? 12 : 10,
              fontWeight: FontWeight.bold,
              color: Color(0xff686868),
            ),
          ),
          _buildSidebarItem('Support', AppAssets.imageIcSupportPng),
          _buildSidebarItem('Settings', AppAssets.imageIcSettingsPng),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(
    String title,
    String imagePath, {
    bool isActive = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath,
            width: 20,
            height: 20,
            color: isActive ? Color(0xffFF5151) : Color(0xffB2B2B2),
          ),
          if (isExpanded) ...[
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                color: isActive ? Color(0xffFF5151) : Color(0xff686868),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
