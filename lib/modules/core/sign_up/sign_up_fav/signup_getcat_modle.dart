//getcat 
class GetCat {
  List<MyData>? data;

  GetCat({this.data});

  GetCat.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MyData>[];
      json['data'].forEach((v) {
        data!.add(new MyData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyData {
  int? id;
  String? category;
  String? createdAt;
  String? updatedAt;

  MyData({this.id, this.category, this.createdAt, this.updatedAt});

  MyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}