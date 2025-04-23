// To parse this JSON data, do
//
//     final jobApplicationsModel = jobApplicationsModelFromJson(jsonString);

import 'dart:convert';

JobApplicationsModel jobApplicationsModelFromJson(String str) => JobApplicationsModel.fromJson(json.decode(str));

String jobApplicationsModelToJson(JobApplicationsModel data) => json.encode(data.toJson());

class JobApplicationsModel {
  bool status;
  String message;
  List<Datum> data;

  JobApplicationsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory JobApplicationsModel.fromJson(Map<String, dynamic> json) => JobApplicationsModel(
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
  int userId;
  String name;
  String image;
  String applicationDate;

  Datum({
    required this.id,
    required this.userId,
    required this.name,
    required this.image,
    required this.applicationDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    image: json["image"],
    applicationDate: json["application_date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "image": image,
    "application_date": applicationDate,
  };
}
