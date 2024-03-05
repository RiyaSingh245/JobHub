import 'package:flutter/material.dart';
import 'package:job_hub/models/response/chat/get_chat.dart';
import 'package:job_hub/services/helpers/chat_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ChatNotifier extends ChangeNotifier {

  late Future<List<GetChats>> chats;
  String? userId;

  getChats() {
    chats = ChatHelper.getConversations();
  }

  getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
  }

  String msgTime(String timestamp) {
    DateTime now = DateTime.now();
    DateTime messageTime = DateTime.parse(timestamp);

    if (now.year == messageTime.year && 
    now.month == messageTime.month && 
    now.day == messageTime.day) {
      return DateFormat.Hm().format(messageTime);
    } else if(now.year == messageTime.year && 
          now.month == messageTime.month && 
          now.day - messageTime.day == 1) {
            return "Yesterday";
    } else {
      return DateFormat.yMd().format(messageTime);
    }
  }
}