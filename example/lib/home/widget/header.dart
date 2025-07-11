import 'package:flutter/material.dart';
import 'package:flutter_device_emulator_example/generated/assets.dart'
    show AppAssets;

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffFFFFFF),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu, color: Color(0xffB3B3B3)),
          SizedBox(width: 10),
          Container(
            width: 250,
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Color(0xffE0E0E0)),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Color(0xffB3B3B3)),
                border: OutlineInputBorder(borderSide: BorderSide.none),
                suffixIcon: Container(
                  padding: EdgeInsets.all(7),
                  child: Image.asset(AppAssets.imageFrame9Png),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ),
          Spacer(),
          Image.asset(AppAssets.imageIcRoundNotificationsPng, height: 24),
          SizedBox(width: 10),
          Image.asset(AppAssets.iconsBiChatLeftDotsFillPng, height: 24),
        ],
      ),
    );
  }
}
