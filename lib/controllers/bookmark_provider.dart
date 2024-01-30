import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_hub/models/request/bookmarks/bookmarks_model.dart';
import 'package:job_hub/models/response/bookmarks/all_bookmarks.dart';
import 'package:job_hub/services/helpers/book_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';

class BookMarkNotifier extends ChangeNotifier {

  Future<List<AllBookmark>>? bookmarks;
  List<String> _jobs = [];
  List<String> get jobs => _jobs;

  set jobs(List<String> newList) {
    _jobs = newList;
    notifyListeners();
  }

  Future<void> addJob(String jobId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(_jobs != null) {
      _jobs.insert(0, jobId);
      prefs.setStringList('jobId', _jobs);
      notifyListeners();
    }
  }

  Future<void> removeJob(String jobId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(_jobs != null) {
      _jobs.remove(jobId);
      prefs.setStringList('jobId', _jobs);
      notifyListeners();
    }
  }

  Future<void> loadJobs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jobs = prefs.getStringList('jobId');

    if(jobs != null) {
      _jobs = jobs;
    }
  }


  addBookMark(BookmarkReqResModel model, String jobId) {
    BookMarkHelper.addBookmarks(model).then((response) {
      if(response[0]) {
        addJob(jobId);
        Get.snackbar("Bookmark successfully added", "Please check your bookmarks",
          colorText: Color(kLight.value),
          backgroundColor: Color(kLightBlue.value),
          icon: const Icon(Icons.bookmark_add)
        );
      } else if (!response[0]) {
        Get.snackbar("Failed to add Bookmark", "Please try again",
          colorText: Color(kOrange.value),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.bookmark_add)
        );
      }
    });
  }

  deleteBookMark(String jobId) {
    BookMarkHelper.deleteBookmarks(jobId).then((response) {
      if(response) {
        removeJob(jobId);
        Get.snackbar("Bookmark successfully deleted", "Please check your bookmarks",
          colorText: Color(kLight.value),
          backgroundColor: Color(kOrange.value),
          icon: const Icon(Icons.bookmark_remove_outlined)
        );
      } else if (!response) {
        Get.snackbar("Failed to delete Bookmark", "Please try again",
          colorText: Color(kOrange.value),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.bookmark_remove_outlined)
        );
      }
    });
  }

  getBookmarks() {
    bookmarks = BookMarkHelper.getBookmarks();
  }
}
