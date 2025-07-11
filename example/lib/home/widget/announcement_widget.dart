import 'package:flutter/material.dart';
import 'package:flutter_device_emulator_example/generated/assets.dart';

class AnnouncementWidget extends StatelessWidget {
  const AnnouncementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffE0E0E0)),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Announcement',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffEFEFEF)),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text('Today, 13 Sep 2021'),
              ),
            ],
          ),
          SizedBox(height: 10),
          ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Color(0xffFAFAFA),
                  border: Border.all(color: Color(0xffE0E0E0)),
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Outing schedule for every departement',
                          style: TextStyle(color: Color(0xff303030)),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '13 Sep 2021',
                          style: TextStyle(
                            color: Color(0xff686868),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Image.asset(
                      AppAssets.imageBiPinAngleFillPng,
                      width: 20,
                      height: 20,
                      color: Color(0xffB2B2B2),
                    ),
                    SizedBox(width: 10),
                    Image.asset(
                      AppAssets.imageCarbonOverflowMenuHorizontalPng,
                      width: 20,
                      height: 20,
                      color: Color(0xffB2B2B2),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
