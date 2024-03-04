import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:job_hub/models/request/messaging/send_message.dart';
import 'package:job_hub/models/response/messaging/messaging_res.dart';
import 'package:job_hub/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessagingHelper {
  static var client = https.Client();

  static Future<List<dynamic>> sendMessage(SendMessage model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.messagingUrl);
    var response = await client.post(
      url, 
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    
    //print("Bookmark details :  ${response.body}");
    if(response.statusCode == 200) {
      ReceivedMessages message = ReceivedMessages.fromJson(jsonDecode(response.body));

      Map<String, dynamic> responseMap = jsonDecode(response.body);
      return [true, message];
    } else {
      return [false];
    }
  }

  static Future<List<ReceivedMessages>> getMessages(String chatId, int offset) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.messagingUrl);
    var response = await client.get(
      url, 
      headers: requestHeaders,
    );
    
    if(response.statusCode == 200) {
      var messages = receivedMessagesFromJson(response.body);
      return messages;
    } else {
      throw Exception("failed to load messages");
    }
  }
}