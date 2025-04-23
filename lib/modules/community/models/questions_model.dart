// To parse this JSON data, do
//
//     final questionsModel = questionsModelFromJson(jsonString);

import 'dart:convert';

QuestionsModel questionsModelFromJson(String str) => QuestionsModel.fromJson(json.decode(str));

String questionsModelToJson(QuestionsModel data) => json.encode(data.toJson());

class QuestionsModel {
  bool status;
  String message;
  List<Datum> data;

  QuestionsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory QuestionsModel.fromJson(Map<String, dynamic> json) => QuestionsModel(
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
  int userId;
  int id;
  String name;
  dynamic image;
  bool isAuth;
  String time;
  int likesCount;
  String content;
  int answersCount;
  bool isMine;
  bool isLiked;

  Datum({
    required this.userId,
    required this.id,
    required this.name,
    required this.image,
    required this.isAuth,
    required this.time,
    required this.likesCount,
    required this.content,
    required this.answersCount,
    required this.isMine,
    required this.isLiked,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    userId: json["user_id"],
    id: json["id"],
    name: json["name"],
    image: json["image"],
    isAuth: json["is_auth"],
    time: json["time"],
    likesCount: json["likes_count"],
    content: json["content"],
    answersCount: json["answers_count"],
    isMine: json["is_mine"],
    isLiked: json["is_liked"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "id": id,
    "name": name,
    "image": image,
    "is_auth": isAuth,
    "time": time,
    "likes_count": likesCount,
    "content": content,
    "answers_count": answersCount,
    "is_mine": isMine,
    "is_liked": isLiked,
  };
}
