import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub/constants/app_constants.dart';
import 'package:job_hub/controllers/chat_provider.dart';
import 'package:job_hub/models/response/chat/get_chat.dart';
import 'package:job_hub/views/common/app_bar.dart';
import 'package:job_hub/views/common/app_style.dart';
import 'package:job_hub/views/common/drawer/drawer_widget.dart';
import 'package:job_hub/views/common/loader.dart';
import 'package:job_hub/views/common/reusable_text.dart';
import 'package:provider/provider.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(50.h), 
      child: CustomAppBar(
      text: "Chats",
      child: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: const DrawerWidget(),
      ),),
      ),

      body: Consumer<ChatNotifier> (
        builder: (context, chatNotifier, child) {
          chatNotifier.getChats();
        return FutureBuilder<List<GetChats>>(
          future: chatNotifier.chats, 
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if(snapshot.hasError) {
              return ReusableText(text: "Error ${snapshot.error}", style: appstyle(20, Color(kOrange.value), FontWeight.bold));
            } else if(snapshot.data!.isEmpty) {
              return const SearchLoading(text: "No Chats Available");
            } else {
              final chats = snapshot.data;
              return ListView.builder(
                itemCount: chats!.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: hieght * 0.26,
                    width: width,
                    color: Color(kOrange.value),
                  );
                }
              );
            }
          });
      }),
    );
  }
}