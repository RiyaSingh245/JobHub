import 'package:flutter/material.dart';
import 'package:job_hub/models/response/chat/get_chat.dart';
import 'package:job_hub/services/helpers/chat_helper.dart';

class ChatNotifier extends ChangeNotifier {

  late Future<List<GetChats>> chats;

  getChats() {
    chats = ChatHelper.getConversations();
  }
}