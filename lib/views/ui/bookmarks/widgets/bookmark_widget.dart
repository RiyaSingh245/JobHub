import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_hub/constants/app_constants.dart';
import 'package:job_hub/controllers/exports.dart';
import 'package:job_hub/models/response/bookmarks/all_bookmarks.dart';
import 'package:job_hub/views/common/app_style.dart';
import 'package:job_hub/views/common/reusable_text.dart';
import 'package:job_hub/views/common/width_spacer.dart';
import 'package:job_hub/views/ui/jobs/job_page.dart';
import 'package:provider/provider.dart';

class BookMarkTileWidget extends StatelessWidget {
  const BookMarkTileWidget({super.key, required this.bookmark});

  final AllBookmark bookmark;

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(builder: (context, jobNotifier, child) {
      jobNotifier.getJob(bookmark.job);
      return FutureBuilder(
          future: jobNotifier.job,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Stack();
            } else if (snapshot.hasError) {
              return Text("Error ${snapshot.error}");
            } else {
              final Job = snapshot.data;
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                        () => JobPage(title: Job.company, id: Job.id));
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                    height: hieght * 0.15,
                    width: width,
                    color: Color(kLightGrey.value),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      NetworkImage(Job!.imageUrl),
                                ),
                                const WidthSpacer(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ReusableText(
                                        text: Job.company,
                                        style: appstyle(20, Color(kDark.value),
                                            FontWeight.w600)),
                                    SizedBox(
                                      width: width * 0.5,
                                      child: ReusableText(
                                          text: Job.title,
                                          style: appstyle(
                                              20,
                                              Color(kDarkGrey.value),
                                              FontWeight.w600)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            CircleAvatar(
                              radius: 18,
                              child: Icon(
                                Ionicons.chevron_forward,
                                color: Color(kOrange.value),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 65.w),
                          child: Row(
                            children: [
                              ReusableText(
                                  text: Job.salary,
                                  style: appstyle(
                                      22, Color(kDark.value), FontWeight.w600)),
                              ReusableText(
                                  text: "/${Job.period}",
                                  style: appstyle(22, Color(kDarkGrey.value),
                                      FontWeight.w600)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          });
    });
  }
}
