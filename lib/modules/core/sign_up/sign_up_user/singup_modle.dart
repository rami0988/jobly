class UserSignupModle {
  bool? status;
  String? message;
  Data? data;

  UserSignupModle({this.status, this.message, this.data});

  UserSignupModle.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? email;
  String? role;
  int? ban;
  int? authentication;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? token;

  Data(
      {this.name,
      this.email,
      this.role,
      this.ban,
      this.authentication,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.token});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    role = json['role'];
    ban = json['ban'];
    authentication = json['authentication'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    data['ban'] = this.ban;
    data['authentication'] = this.authentication;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['token'] = this.token;
    return data;
  }
}
