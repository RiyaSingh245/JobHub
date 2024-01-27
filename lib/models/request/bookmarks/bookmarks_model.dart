import 'dart:convert';

BookmarkReqResModel bookmarkReqModelFromJson(String str) => BookmarkReqResModel.fromJson(json.decode(str));

String bookmarkReqModelToJson(BookmarkReqResModel data) => json.encode(data.toJson());

class BookmarkReqResModel {
    BookmarkReqResModel({
        required this.job,
    });

    final String job;

    factory BookmarkReqResModel.fromJson(Map<String, dynamic> json) => BookmarkReqResModel(
        job: json["job"],
    );

    Map<String, dynamic> toJson() => {
        "job": job,
    };
}
