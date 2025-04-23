// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    bool status;
    String message;
    Data? data;

    ProfileModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    int id;
    String name;
    String email;
    int role;
    int authentication;
    int ban;
    dynamic emailVerifiedAt;
    DateTime createdAt;
    DateTime updatedAt;
    int points;
    List<dynamic> advices;
    Employee employee;
    Address? address;

    Data({
        required this.id,
        required this.name,
        required this.email,
        required this.role,
        required this.authentication,
        required this.ban,
        required this.emailVerifiedAt,
        required this.createdAt,
        required this.updatedAt,
        required this.points,
        required this.advices,
        required this.employee,
         this.address,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        authentication: json["authentication"],
        ban: json["ban"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        points: json["points"],
        advices: json["advices"],
        employee: Employee.fromJson(json["employee"]),
        address: json["address"] != null ? Address.fromJson(json["address"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "role": role,
        "authentication": authentication,
        "ban": ban,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "points": points,
        "advices": List<dynamic>.from(advices.map((x) => x.toJson())),
        "employee": employee.toJson(),
        "address": address?.toJson(),
    };
}

class Address {
    int id;
    int userId;
    String county;
    String city;
    String governorate;
    DateTime createdAt;
    DateTime updatedAt;

    Address({
        required this.id,
        required this.userId,
        required this.county,
        required this.city,
        required this.governorate,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        userId: json["user_id"],
        county: json["county"],
        city: json["city"],
        governorate: json["Governorate"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "county": county,
        "city": city,
        "Governorate": governorate,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class Advice {
    int id;
    String name;
    String? image;
    bool isAuth;
    String time;
    int likesCount;
    String content;
    bool isMine;
    bool isLiked;

    Advice({
        required this.id,
        required this.name,
        required this.image,
        required this.isAuth,
        required this.time,
        required this.likesCount,
        required this.content,
        required this.isMine,
        required this.isLiked,
    });

    factory Advice.fromJson(Map<String, dynamic> json) => Advice(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        isAuth: json["is_auth"],
        time: json["time"],
        likesCount: json["likes_count"],
        content: json["content"],
        isMine: json["is_mine"],
        isLiked: json["is_liked"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "is_auth": isAuth,
        "time": time,
        "likes_count": likesCount,
        "content": content,
        "is_mine": isMine,
        "is_liked": isLiked,
    };
}

class Employee {
    int id;
    int userId;
    String? cv;
    String dateOfBirth;
    String resume;
    String experience;
    String education;
    String? portfolio;
    String phoneNumber;
    String workStatus;
    String graduationStatus;
    DateTime createdAt;
    DateTime updatedAt;
    Image? image;
    Video? video;
    List<Skill> skills;

    Employee({
        required this.id,
        required this.userId,
         this.cv,
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
         this.image,
         this.video,
        required this.skills,
    });

    factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        userId: json["user_id"],
        cv: json["cv"],
        dateOfBirth: json["date_of_birth"],
        resume: json["resume"],
        experience: json["experience"],
        education: json["education"],
        portfolio: json["portfolio"],
        phoneNumber: json["phone_number"],
        workStatus: json["work_status"],
        graduationStatus: json["graduation_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        image: json["image"] != null ? Image.fromJson(json["image"]) : null,
        video: json["video"] != null ? Video.fromJson(json["video"]) : null,
        skills: List<Skill>.from(json["skills"].map((x) => Skill.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "cv": cv,
        "date_of_birth": dateOfBirth,
        "resume": resume,
        "experience": experience,
        "education": education,
        "portfolio": portfolio,
        "phone_number": phoneNumber,
        "work_status": workStatus,
        "graduation_status": graduationStatus,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "image": image?.toJson(),
        "video": video?.toJson(),
        "skills": List<dynamic>.from(skills.map((x) => x.toJson())),
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

class Skill {
    int id;
    int employeeId;
    String skill;
    DateTime createdAt;
    DateTime updatedAt;

    Skill({
        required this.id,
        required this.employeeId,
        required this.skill,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        id: json["id"],
        employeeId: json["employee_id"],
        skill: json["skill"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "skill": skill,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class Video {
    int id;
    String filename;
    int videoableId;
    String videoableType;
    DateTime createdAt;
    DateTime updatedAt;

    Video({
        required this.id,
        required this.filename,
        required this.videoableId,
        required this.videoableType,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        filename: json["filename"],
        videoableId: json["videoable_id"],
        videoableType: json["videoable_type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "filename": filename,
        "videoable_id": videoableId,
        "videoable_type": videoableType,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
