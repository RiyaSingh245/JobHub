import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_hub/constants/app_constants.dart';
import 'package:job_hub/controllers/chat_provider.dart';
import 'package:job_hub/models/request/messaging/send_message.dart';
import 'package:job_hub/models/response/messaging/messaging_res.dart';
import 'package:job_hub/services/helpers/messaging_helper.dart';
import 'package:job_hub/views/common/app_bar.dart';
import 'package:job_hub/views/common/app_style.dart';
import 'package:job_hub/views/common/height_spacer.dart';
import 'package:job_hub/views/common/loader.dart';
import 'package:job_hub/views/common/reusable_text.dart';
import 'package:job_hub/views/ui/chat/widgets/textfield.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

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
  IO.Socket? socket;

  late Future<List<ReceivedMessages>> msgList;
  TextEditingController messageController = TextEditingController();
  late List<ReceivedMessages> messages;
  String receiver = '';

  @override
  void initState() {
    getMessages();
    connect();
    joinChat();
    super.initState();
  }

  void getMessages() {
    msgList = MessagingHelper.getMessages(widget.id, offset);
  }

  void connect() {
    var chatNotifier = Provider.of<ChatNotifier>(context, listen: false);
    socket = IO.io(
        'https://jobhubrest-production-8fc8.up.railway.app', <String, dynamic>{
      "transports": ['websocket'],
      "autoConnect": false,
    });
    socket!.emit("setup", chatNotifier.userId);
    socket!.connect();
    socket!.onConnect((_) {
      //print("Connected to Frontend");
      socket!.on('online-users', (userId) {
        chatNotifier.online
            .replaceRange(0, chatNotifier.online.length, [userId]);
      });

      socket!.on('typing', (status) {
        chatNotifier.typingStatus = false;
      });

      socket!.on('stop typing', (status) {
        chatNotifier.typingStatus = true;
      });

      socket!.on('message received', (newMessageReceived) {
        sendStopTypingEvent(widget.id);
        ReceivedMessages receivedMessages =
            ReceivedMessages.fromJson(newMessageReceived);
        if (receivedMessages.sender.id != chatNotifier.userId) {
          setState(() {
            messages.insert(0, receivedMessages);
          });
        }
      });
    });
  }

  void sendMessage(String content, String chatId, String receiver) {
    SendMessage model =
        SendMessage(content: content, chatId: chatId, receiver: receiver);

    MessagingHelper.sendMessage(model).then((response) {
      var emmission = response[2];
      socket!.emit('new message', emmission);
      sendStopTypingEvent(widget.id);
      setState(() {
        messageController.clear();
        messages.insert(0, response[1]);
      });
    });
  }

  void sendTypingEvent(String status) {
    socket!.emit('typing', status);
  }

  void sendStopTypingEvent(String status) {
    socket!.emit('stop typing', status);
  }

  void joinChat() {
    socket!.emit('join chat', widget.id);
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
        receiver = widget.user.firstWhere((id) => id != chatNotifier.userId);
        return SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<List<ReceivedMessages>>(
                    future: msgList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
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
                                    ReusableText(
                                        text: chatNotifier.msgTime(
                                            data.chat.updatedAt.toString()),
                                        style: appstyle(16, Color(kDark.value),
                                            FontWeight.normal)),
                                    const HeightSpacer(size: 15),
                                    ChatBubble(
                                      alignment:
                                          data.sender.id == chatNotifier.userId
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                      backGroundColor:
                                          data.sender.id == chatNotifier.userId
                                              ? Color(kOrange.value)
                                              : Color(kLightGrey.value),
                                      elevation: 0,
                                      clipper: ChatBubbleClipper4(
                                        radius: 8,
                                        type: data.sender.id ==
                                                chatNotifier.userId
                                            ? BubbleType.sendBubble
                                            : BubbleType.receiverBubble,
                                      ),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth: width * 0.8,
                                        ),
                                        child: ReusableText(
                                            text: data.content,
                                            style: appstyle(
                                                14,
                                                Color(kLight.value),
                                                FontWeight.normal)),
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
                  child: MessagingTextField(
                      suffixIcon: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.send,
                          size: 24,
                          color: Color(kLightBlue.value),
                        ),
                      ),
                      messageController: messageController)),
            ],
          ),
        ));
      }),
    );
  }
}
