import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_hub/constants/app_constants.dart';
import 'package:job_hub/views/common/app_bar.dart';
import 'package:job_hub/views/common/app_style.dart';
import 'package:job_hub/views/common/drawer/drawer_widget.dart';
import 'package:job_hub/views/common/heading_widget.dart';
import 'package:job_hub/views/common/height_spacer.dart';
import 'package:job_hub/views/common/search.dart';
import 'package:job_hub/views/common/vertical_tile.dart';
import 'package:job_hub/views/ui/jobs/job_page.dart';
import 'package:job_hub/views/ui/jobs/widgets/horizontal_tile.dart';
import 'package:job_hub/views/ui/search/searchpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(50.h), 
      child: CustomAppBar(
      actions: [
        Padding(padding: EdgeInsets.all(12.h),
        child: const CircleAvatar(
          radius: 15,
          backgroundImage: AssetImage("assets/images/user.png"),
        )) 
      ],
      child: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: const DrawerWidget(),
      ),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeightSpacer(size: 10),
                Text("Search \nFind & Apply", 
                style: appstyle(40, Color(kDark.value), FontWeight.bold),),
                const HeightSpacer(size: 40),
                SearchWidget(
                  onTap: () {
                    Get.to(()=> const SearchPage());
                  },
                ),
                const HeightSpacer(size: 30),
                HeadingWidget(
                  text: "Popular Jobs",
                  onTap: () {},
                ),

                const HeightSpacer(size: 15),

                SizedBox(
                  height: hieght*0.28,
                  child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return JobHorizontalTile(
                        onTap: () {
                          Get.to(() => const JobPage(title: 'Facebook', id: '12',));
                        },
                      );
                    }
                    ),
                ),
                const HeightSpacer(size: 15),
                HeadingWidget(
                  text: "Recently Posted",
                  onTap: () {},
                ),
                const HeightSpacer(size: 15),
                VerticalTile(
                  onTap: () {},
                ),
              ],
            ),
            ),
        )),
    );
  }
}