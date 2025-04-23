// To parse this JSON data, do
//
//     final citiesModel = citiesModelFromJson(jsonString);

import 'dart:convert';

CitiesModel citiesModelFromJson(String str) => CitiesModel.fromJson(json.decode(str));

String citiesModelToJson(CitiesModel data) => json.encode(data.toJson());

class CitiesModel {
  bool status;
  String message;
  List<Datum> data;

  CitiesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CitiesModel.fromJson(Map<String, dynamic> json) => CitiesModel(
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
  String county;
  String city;
  String governorate;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.vacancyId,
    required this.county,
    required this.city,
    required this.governorate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
