import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_hub/constants/app_constants.dart';
import 'package:job_hub/controllers/chat_provider.dart';
import 'package:job_hub/models/response/messaging/messaging_res.dart';
import 'package:job_hub/services/helpers/messaging_helper.dart';
import 'package:job_hub/views/common/app_bar.dart';
import 'package:job_hub/views/common/app_style.dart';
import 'package:job_hub/views/common/height_spacer.dart';
import 'package:job_hub/views/common/loader.dart';
import 'package:job_hub/views/common/reusable_text.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key,
      required this.title,
      required this.id,
      required this.profile,
      required this.user});

  final String title;
  final String id;
  final String profile;
  final List<String> user;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int offset = 1;
  late Future<List<ReceivedMessages>> msgList;
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    getMessages();
    super.initState();
  }

  void getMessages() {
    msgList = MessagingHelper.getMessages(widget.id, offset);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: widget.title,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.profile),
                  ),
                  const Positioned(
                      right: 3,
                      child: CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.green,
                      )),
                ],
              ),
            ),
          ],
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(MaterialCommunityIcons.arrow_left),
            ),
          ),
        ),
      ),
      body: Consumer<ChatNotifier>(builder: (context, chatNotifier, child) {
        return SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h),
          child: Column(
            children: [
              Expanded(
                  child: FutureBuilder<List<ReceivedMessages>>(
                      future: msgList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return ReusableText(
                              text: "Error ${snapshot.error}",
                              style: appstyle(
                                  20, Color(kOrange.value), FontWeight.bold));
                        } else if (snapshot.data!.isEmpty) {
                          return const SearchLoading(
                              text: "You do not have message");
                        } else {
                          final chats = snapshot.data;
                          return ListView.builder(
                              padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
                              itemCount: chats!.length,
                              itemBuilder: (context, index) {
                                final data = chats[index];
                                return Padding(
                                  padding: EdgeInsets.only(top: 8, bottom: 12.h),

                                  child: Column(
                                    children: [
                                      ReusableText(text: chatNotifier.msgTime(data.chat.updatedAt.toString()), 
                                        style: appstyle(16, Color(kDark.value), FontWeight.normal)),

                                        const HeightSpacer(size: 15),

                                        ChatBubble(
                                          alignment: data.sender.id == chatNotifier.userId
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                          backGroundColor: data.sender.id == chatNotifier.userId
                                          ? Color(kOrange.value)
                                          : Color(kLightGrey.value),
                                          elevation: 0,
                                          clipper: ChatBubbleClipper4(
                                            radius: 8,
                                            type: data.sender.id == chatNotifier.userId
                                            ? BubbleType.sendBubble
                                            : BubbleType.receiverBubble,
                                          ),
                                          child: Container(
                                            constraints: BoxConstraints(
                                              maxWidth: width * 0.8,
                                            ),
                                            child: ReusableText(
                                              text: data.content, 
                                              style: appstyle(14, Color(kLight.value), FontWeight.normal)
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                );
                              });
                        }
                      }),
                      ),
                      Container(
                        padding: EdgeInsets.all(12.h),
                        alignment: Alignment.bottomCenter,
                        child: TextField(
                          cursorColor: Color(kDarkGrey.value),
                          controller: messageController,
                          keyboardType: TextInputType.multiline,
                          style: appstyle(16, Color(kDark.value), FontWeight.w500),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(6.h),
                            filled: true,
                            fillColor: Color(kLight.value),
                            suffixIcon: GestureDetector(
                              onTap: () {},
                              child: const Icon(Icons.send, size: 24,),
                            ),
                          ),
                        ),
                      )
            ],
          ),
        ));
      }),
    );
  }
}
