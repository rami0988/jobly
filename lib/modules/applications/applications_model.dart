// To parse this JSON data, do
//
//     final myApplicationsModel = myApplicationsModelFromJson(jsonString);

import 'dart:convert';

MyApplicationsModel myApplicationsModelFromJson(String str) => MyApplicationsModel.fromJson(json.decode(str));

String myApplicationsModelToJson(MyApplicationsModel data) => json.encode(data.toJson());

class MyApplicationsModel {
  bool status;
  String message;
  List<Datum> data;

  MyApplicationsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MyApplicationsModel.fromJson(Map<String, dynamic> json) => MyApplicationsModel(
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
  int id;
  int vacancyId;
  String jobTitle;
  String status;
  String publisherName;
  String? publisherPhoto;
  Location? location;
  String date;

  Datum({
    required this.id,
    required this.vacancyId,
    required this.jobTitle,
    required this.status,
    required this.publisherName,
    required this.publisherPhoto,
    required this.location,
    required this.date,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    vacancyId: json["vacancy_id"],
    jobTitle: json["job_title"],
    status: json["status"],
    publisherName: json["publisher_name"],
    publisherPhoto: json["publisher_photo"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "vacancy_id": vacancyId,
    "job_title": jobTitle,
    "status": status,
    "publisher_name": publisherName,
    "publisher_photo": publisherPhoto,
    "location": location?.toJson(),
    "date": date,
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
