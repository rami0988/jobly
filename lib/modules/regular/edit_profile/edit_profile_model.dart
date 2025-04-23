// To parse this JSON data, do
//
//     final editProfileModel = editProfileModelFromJson(jsonString);

import 'dart:convert';

EditProfileModel editProfileModelFromJson(String str) => EditProfileModel.fromJson(json.decode(str));

String editProfileModelToJson(EditProfileModel data) => json.encode(data.toJson());

class EditProfileModel {
  bool status;
  String message;
  Data data;

  EditProfileModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EditProfileModel.fromJson(Map<String, dynamic> json) => EditProfileModel(
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
  int id;
  int userId;
  String cv;
  DateTime dateOfBirth;
  String resume;
  String experience;
  String education;
  String portfolio;
  String phoneNumber;
  String workStatus;
  String graduationStatus;
  DateTime createdAt;
  DateTime updatedAt;
  Image image;

  Data({
    required this.id,
    required this.userId,
    required this.cv,
    required this.dateOfBirth,
    required this.resume,
    required this.experience,
    required this.education,
    required this.portfolio,
    required this.phoneNumber,
    required this.workStatus,
    required this.graduationStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["user_id"],
    cv: json["cv"],
    dateOfBirth: DateTime.parse(json["date_of_birth"]),
    resume: json["resume"],
    experience: json["experience"],
    education: json["education"],
    portfolio: json["portfolio"],
    phoneNumber: json["phone_number"],
    workStatus: json["work_status"],
    graduationStatus: json["graduation_status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    image: Image.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "cv": cv,
    "date_of_birth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
    "resume": resume,
    "experience": experience,
    "education": education,
    "portfolio": portfolio,
    "phone_number": phoneNumber,
    "work_status": workStatus,
    "graduation_status": graduationStatus,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "image": image.toJson(),
  };
}

class Image {
  int id;
  String filename;
  int imageableId;
  String imageableType;
  DateTime createdAt;
  DateTime updatedAt;

  Image({
    required this.id,
    required this.filename,
    required this.imageableId,
    required this.imageableType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    filename: json["filename"],
    imageableId: json["imageable_id"],
    imageableType: json["imageable_type"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "filename": filename,
    "imageable_id": imageableId,
    "imageable_type": imageableType,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
