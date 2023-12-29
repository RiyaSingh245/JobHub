import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:job_hub/constants/app_constants.dart';
import 'package:job_hub/views/common/app_bar.dart';
import 'package:job_hub/views/common/app_style.dart';
import 'package:job_hub/views/common/drawer/drawer_widget.dart';
import 'package:job_hub/views/common/reusable_text.dart';
import 'package:job_hub/views/common/width_spacer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(50.h), 
      child: CustomAppBar(
      text: "Profile",
      child: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: const DrawerWidget(),
      ),),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:20.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              width: width,
              height: hieght*0.1,
              color: Color(kLight.value),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        child: CachedNetworkImage(
                          width: 80.w,
                          height: 100.h,
                          imageUrl: "https://picsum.photos/250?image=9",),
                      ),
                    ],
                  ),
                  const WidthSpacer(width: 20),
        
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ReusableText(
                        text: "Riya Singh", 
                        style: appstyle(20, Color(kDark.value), FontWeight.w600),
                      ),
        
                      Row(
                        children: [
                          Icon(MaterialIcons.location_pin, 
                          color: Color(kDarkGrey.value),),
        
                          const WidthSpacer(width: 5),
        
                          ReusableText(
                            text: "Kolkata, WB", 
                            style: appstyle(16, Color(kDarkGrey.value), FontWeight.w600),
                          ),
                        ],
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(Feather.edit, size: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}