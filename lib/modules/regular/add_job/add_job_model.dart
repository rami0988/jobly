// To parse this JSON data, do
//
//     final addJobModel = addJobModelFromJson(jsonString);

import 'dart:convert';

AddJobModel addJobModelFromJson(String str) => AddJobModel.fromJson(json.decode(str));

String addJobModelToJson(AddJobModel data) => json.encode(data.toJson());

class AddJobModel {
  bool status;
  String message;
  Data data;

  AddJobModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AddJobModel.fromJson(Map<String, dynamic> json) => AddJobModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String description;
  String jobType;
  String requirements;
  String salaryRange;
  String applicationDeadline;
  String status;
  String jopsSectionId;
  int userId;
  DateTime updatedAt;
  DateTime createdAt;
  int id;
  String image;

  Data({
    required this.description,
    required this.jobType,
    required this.requirements,
    required this.salaryRange,
    required this.applicationDeadline,
    required this.status,
    required this.jopsSectionId,
    required this.userId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.image,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    description: json["description"],
    jobType: json["job_type"],
    requirements: json["requirements"],
    salaryRange: json["salary_range"],
    applicationDeadline: json["application_deadline"],
    status: json["status"],
    jopsSectionId: json["jops_section_id"],
    userId: json["user_id"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "job_type": jobType,
    "requirements": requirements,
    "salary_range": salaryRange,
    "application_deadline": applicationDeadline,
    "status": status,
    "jops_section_id": jopsSectionId,
    "user_id": userId,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
    "image": image,
  };
}
