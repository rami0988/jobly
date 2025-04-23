// To parse this JSON data, do
//
//     final announcementsModel = announcementsModelFromJson(jsonString);

import 'dart:convert';

AnnouncementsModel announcementsModelFromJson(String str) => AnnouncementsModel.fromJson(json.decode(str));

String announcementsModelToJson(AnnouncementsModel data) => json.encode(data.toJson());

class AnnouncementsModel {
  bool status;
  String message;
  List<Datum> data;

  AnnouncementsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AnnouncementsModel.fromJson(Map<String, dynamic> json) => AnnouncementsModel(
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
  String companyName;
  String companyPhoto;
  String duration;
  bool isAuth;
  String companyEmail;
  String title;
  String type;
  String startDate;
  String days;
  String time;
  String price;
  String createdAt;

  Datum({
    required this.id,
    required this.companyName,
    required this.companyPhoto,
    required this.duration,
    required this.isAuth,
    required this.companyEmail,
    required this.title,
    required this.type,
    required this.startDate,
    required this.days,
    required this.time,
    required this.price,
    required this.createdAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    companyName: json["company_name"],
    companyPhoto: json["company_photo"],
    duration: json["duration"],
    isAuth: json["is_auth"],
    companyEmail: json["company_email"],
    title: json["title"],
    type: json["type"],
    startDate: json["start_date"],
    days: json["days"],
    time: json["time"],
    price: json["price"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_name": companyName,
    "company_photo": companyPhoto,
    "duration": duration,
    "is_auth": isAuth,
    "company_email": companyEmail,
    "title": title,
    "type": type,
    "start_date": startDate,
    "days": days,
    "time": time,
    "price": price,
    "created_at": createdAt,
  };
}
