import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:job_hub/models/request/bookmarks/bookmarks_model.dart';
import 'package:job_hub/models/response/bookmarks/book_res.dart';
import 'package:job_hub/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookMarkHelper {
  static var client = https.Client();

// Add bookmarks
  static Future<List<dynamic>> addBookmarks(BookmarkReqResModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.bookmarkUrl);
    var response = await client.post(
      url, 
      headers: requestHeaders,
      body: jsonEncode(model.toJson())
    );
    
    if(response.statusCode == 200) {
      String bookmarkId = bookMarkReqResFromJson(response.body).id;
      return [true, bookmarkId];
    } else {
      return [false];
    }
  }

// Delete BookMark
  static Future<bool> deleteBookmarks(String jobId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, "${Config.bookmarkUrl}/$jobId");
    var response = await client.delete(
      url, 
      headers: requestHeaders,
    );
    
    if(response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}