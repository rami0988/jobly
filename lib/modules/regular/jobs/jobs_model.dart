// To parse this JSON data, do
//
//     final jobsModel = jobsModelFromJson(jsonString);

import 'dart:convert';

JobsModel jobsModelFromJson(String str) => JobsModel.fromJson(json.decode(str));

String jobsModelToJson(JobsModel data) => json.encode(data.toJson());

class JobsModel {
  bool status;
  String message;
  List<Datum> data;

  JobsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory JobsModel.fromJson(Map<String, dynamic> json) => JobsModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String companyName;
  String section;
  String category;
  int vacancyId;
  int userId;
  String description;
  String? vacancyImage;
  String? publisherPhoto;
  String jobType;
  String status;
  String requirements;
  String salaryRange;
  String applicationDeadline;
  Location? location;

  Datum({
    required this.companyName,
    required this.section,
    required this.category,
    required this.vacancyId,
    required this.userId,
    required this.description,
    required this.vacancyImage,
    required this.publisherPhoto,
    required this.jobType,
    required this.status,
    required this.requirements,
    required this.salaryRange,
    required this.applicationDeadline,
    required this.location,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    companyName: json["company_name"],
    section: json["section"],
    category: json["category"],
    vacancyId: json["vacancy_id"],
    userId: json["user_id"],
    description: json["description"],
    vacancyImage: json["vacancy_image"],
    publisherPhoto: json["publisher_photo"],
    jobType: json["job_type"],
    status: json["status"],
    requirements: json["requirements"],
    salaryRange: json["salary_range"],
    applicationDeadline: json["application_deadline"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "company_name": companyName,
    "section": section,
    "category": category,
    "vacancy_id": vacancyId,
    "user_id": userId,
    "description": description,
    "vacancy_image": vacancyImage,
    "publisher_photo": publisherPhoto,
    "job_type": jobType,
    "status": status,
    "requirements": requirements,
    "salary_range": salaryRange,
    "application_deadline": applicationDeadline,
    "location": location?.toJson(),
  };
}

class Location {
  int id;
  int vacancyId;
  String county;
  String city;
  String governorate;
  DateTime createdAt;
  DateTime updatedAt;

  Location({
    required this.id,
    required this.vacancyId,
    required this.county,
    required this.city,
    required this.governorate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json["id"],
    vacancyId: json["vacancy_id"],
    county: json["county"],
    city: json["city"],
    governorate: json["Governorate"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vacancy_id": vacancyId,
    "county": county,
    "city": city,
    "Governorate": governorate,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
