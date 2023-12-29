import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:job_hub/constants/app_constants.dart';
import 'package:job_hub/views/common/app_style.dart';
import 'package:job_hub/views/common/height_spacer.dart';
import 'package:job_hub/views/common/reusable_text.dart';
import 'package:job_hub/views/common/width_spacer.dart';

class VerticalTile extends StatelessWidget {
  const VerticalTile({super.key, this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        height: hieght * 0.22,
        width: width,
        color: Color(kLightGrey.value),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(kLightGrey.value),
                      radius: 25,
                      backgroundImage: AssetImage("assets/images/slack.png"),
                    ),
                    const WidthSpacer(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                            text: "Slack",
                            style: appstyle(
                                20, Color(kDark.value), FontWeight.w600)),
                        SizedBox(
                          width: width * 0.5,
                          child: ReusableText(
                              text: "Consultant",
                              style: appstyle(
                                  18, Color(kDarkGrey.value), FontWeight.w600)),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(kLight.value),
                      child: const Icon(Ionicons.chevron_forward),
                    ),
                  ],
                ),
              ],
            ),
            const HeightSpacer(size: 20),  
            Padding(padding: EdgeInsets.only(left: 12.w),
                child: Row(
                  children: [
                    ReusableText(
                      text: "20k", 
                      style: appstyle(23, Color(kDark.value), FontWeight.w600),),
                    ReusableText(
                      text: "/monthly", 
                      style: appstyle(23, Color(kDarkGrey.value), FontWeight.w600),),  
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
