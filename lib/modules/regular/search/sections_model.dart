// To parse this JSON data, do
//
//     final sectionsModel = sectionsModelFromJson(jsonString);

import 'dart:convert';

SectionsModel sectionsModelFromJson(String str) => SectionsModel.fromJson(json.decode(str));

String sectionsModelToJson(SectionsModel data) => json.encode(data.toJson());

class SectionsModel {
  bool status;
  String message;
  List<Datum> data;

  SectionsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SectionsModel.fromJson(Map<String, dynamic> json) => SectionsModel(
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
  int jopsCategoryId;
  String section;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.jopsCategoryId,
    required this.section,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    jopsCategoryId: json["jops_category_id"],
    section: json["section"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "jops_category_id": jopsCategoryId,
    "section": section,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
