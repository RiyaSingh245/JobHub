import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub/constants/app_constants.dart';
import 'package:job_hub/views/common/app_style.dart';
import 'package:job_hub/views/common/reusable_text.dart';
import 'package:job_hub/views/common/width_spacer.dart';

class VerticalTileWidget extends StatelessWidget {
  const VerticalTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
          height: hieght*0.15,
          width: width,
          color: Color(kLightGrey.value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(""),

                  ),
                  WidthSpacer(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        text: "", 
                        style: appstyle(20, Color(kDark.value), FontWeight.w600)
                      ),
                      SizedBox(
                        width: width*0.5,
                        child: ReusableText(
                        text: "", 
                        style: appstyle(20, Color(kDark.value), FontWeight.w600)
                      ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}