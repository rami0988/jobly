class SignUpAddressModlee {
  bool? status;
  String? message;
  Data? data;

  SignUpAddressModlee({this.status, this.message, this.data});

  SignUpAddressModlee.fromJson(Map<String, dynamic> json) {
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
  String? county;
  String? city;
  String? governorate;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.county,
      this.city,
      this.governorate,
      this.userId,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    county = json['county'];
    city = json['city'];
    governorate = json['Governorate'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['county'] = this.county;
    data['city'] = this.city;
    data['Governorate'] = this.governorate;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
