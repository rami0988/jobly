class SignUpEmployyModlee {
  bool? status;
  String? message;
  Data? data;

  SignUpEmployyModlee({this.status, this.message, this.data});

  SignUpEmployyModlee.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  String? dateOfBirth;
  String? resume;
  String? experience;
  String? education;
  String? portfolio;
  String? phoneNumber;
  String? workStatus;
  String? graduationStatus;
  String? updatedAt;
  String? createdAt;
  int? id;
  Image? image;

  Data(
      {this.userId,
      this.dateOfBirth,
      this.resume,
      this.experience,
      this.education,
      this.portfolio,
      this.phoneNumber,
      this.workStatus,
      this.graduationStatus,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.image});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    dateOfBirth = json['date_of_birth'];
    resume = json['resume'];
    experience = json['experience'];
    education = json['education'];
    portfolio = json['portfolio'];
    phoneNumber = json['phone_number'];
    workStatus = json['work_status'];
    graduationStatus = json['graduation_status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['date_of_birth'] = this.dateOfBirth;
    data['resume'] = this.resume;
    data['experience'] = this.experience;
    data['education'] = this.education;
    data['portfolio'] = this.portfolio;
    data['phone_number'] = this.phoneNumber;
    data['work_status'] = this.workStatus;
    data['graduation_status'] = this.graduationStatus;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    return data;
  }
}

class Image {
  int? id;
  String? filename;
  int? imageableId;
  String? imageableType;
  String? createdAt;
  String? updatedAt;

  Image(
      {this.id,
      this.filename,
      this.imageableId,
      this.imageableType,
      this.createdAt,
      this.updatedAt});

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    filename = json['filename'];
    imageableId = json['imageable_id'];
    imageableType = json['imageable_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['filename'] = this.filename;
    data['imageable_id'] = this.imageableId;
    data['imageable_type'] = this.imageableType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
