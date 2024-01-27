import 'dart:convert';

List<AllBookmark> allBookmarkFromJson(String str) => List<AllBookmark>.from(json.decode(str).map((x) => AllBookmark.fromJson(x)));

class AllBookmark {
    final String id;
    final String job;
    final String userId;

    AllBookmark({
        required this.id,
        required this.job,
        required this.userId,
    });

    factory AllBookmark.fromJson(Map<String, dynamic> json) => AllBookmark(
        id: json["_id"],
        job: json["job"],
        userId: json["userId"],
    );
}