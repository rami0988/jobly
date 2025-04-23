// To parse this JSON data, do
//
//     final sectionsByCategoryModel = sectionsByCategoryModelFromJson(jsonString);

import 'dart:convert';

SectionsByCategoryModel sectionsByCategoryModelFromJson(String str) => SectionsByCategoryModel.fromJson(json.decode(str));

String sectionsByCategoryModelToJson(SectionsByCategoryModel data) => json.encode(data.toJson());

class SectionsByCategoryModel {
  bool status;
  String message;
  List<Datum> data;

  SectionsByCategoryModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SectionsByCategoryModel.fromJson(Map<String, dynamic> json) => SectionsByCategoryModel(
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
  String section;

  Datum({
    required this.id,
    required this.section,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    section: json["section"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "section": section,
  };
}
