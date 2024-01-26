import 'dart:convert';

GetJobRes getJobResFromJson(String str) => GetJobRes.fromJson(json.decode(str));

String getJobResToJson(GetJobRes data) => json.encode(data.toJson());

class GetJobRes {
    GetJobRes({
        required this.id,
        required this.title,
        required this.location,
        required this.company,
        this.hiring,
        required this.description,
        required this.salary,
        required this.period,
        required this.contract,
        required this.requirements,
        required this.imageUrl,
        required this.agentId,
        //required this.createdAt,
        //required this.updatedAt,
    });

    final String id;
    final String title;
    final String location;
    final String company;
    final bool? hiring;
    final String description;
    final String salary;
    final String period;
    final String contract;
    final List<String> requirements;
    final String imageUrl;
    final String agentId;
    //final DateTime createdAt;
    //final DateTime updatedAt;

    factory GetJobRes.fromJson(Map<String, dynamic> json) => GetJobRes(
        id: json["_id"],
        title: json["title"],
        location: json["location"],
        company: json["company"],
        hiring: json["hiring"],
        description: json["description"],
        salary: json["salary"],
        period: json["period"],
        contract: json["contract"],
        requirements: List<String>.from(json["requirements"].map((x) => x)),
        imageUrl: json["imageUrl"],
        agentId: json["agentId"],
        //createdAt: DateTime.parse(json["createdAt"]),
        //updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "location": location,
        "company": company,
        "hiring": hiring,
        "description": description,
        "salary": salary,
        "period": period,
        "contract": contract,
        "requirements": List<dynamic>.from(requirements.map((x) => x)),
        "imageUrl": imageUrl,
        "agentId": agentId,
        //"createdAt": createdAt.toIso8601String(),
        //"updatedAt": updatedAt.toIso8601String(),
    };
}
