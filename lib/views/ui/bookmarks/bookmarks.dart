import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub/views/common/app_bar.dart';
import 'package:job_hub/views/common/drawer/drawer_widget.dart';

class BookMarkPage extends StatefulWidget {
  const BookMarkPage({super.key});

  @override
  State<BookMarkPage> createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(50.h), 
      child: CustomAppBar(
      text: "BookMarks",
      child: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: const DrawerWidget(),
      ),),
      ),
    );
  }
}