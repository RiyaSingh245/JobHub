import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub/views/common/app_bar.dart';
import 'package:job_hub/views/common/drawer/drawer_widget.dart';

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
      text: "Profile Page",
      child: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: const DrawerWidget(),
      ),),
      ),
    );
  }
}