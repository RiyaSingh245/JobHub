
import 'dart:convert';

List<AllBookmark> allBookmarkFromJson(String str) => List<AllBookmark>.from(json.decode(str).map((x) => AllBookmark.fromJson(x)));

class AllBookmark {
    final String id;
    final String job;
    final String userId;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    AllBookmark({
        required this.id,
        required this.job,
        required this.userId,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory AllBookmark.fromJson(Map<String, dynamic> json) => AllBookmark(
        id: json["_id"],
        job: json["job"],
        userId: json["userId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );
}
