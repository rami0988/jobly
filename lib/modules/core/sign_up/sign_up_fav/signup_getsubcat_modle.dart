class SubCatModle {
  List<SubData>? data;

  SubCatModle({this.data});

  SubCatModle.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SubData>[];
      json['data'].forEach((v) {
        data!.add(new SubData.fromJson(v));
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

class SubData {
  int? id;
  String? category;
  String? createdAt;
  String? updatedAt;
  List<JopsSection>? jopsSection;

  SubData(
      {this.id,
      this.category,
      this.createdAt,
      this.updatedAt,
      this.jopsSection});

  SubData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['jops_section'] != null) {
      jopsSection = <JopsSection>[];
      json['jops_section'].forEach((v) {
        jopsSection!.add(new JopsSection.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.jopsSection != null) {
      data['jops_section'] = this.jopsSection!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JopsSection {
  int? id;
  int? jopsCategoryId;
  String? section;
  String? createdAt;
  String? updatedAt;

  JopsSection(
      {this.id,
      this.jopsCategoryId,
      this.section,
      this.createdAt,
      this.updatedAt});

  JopsSection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jopsCategoryId = json['jops_category_id'];
    section = json['section'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jops_category_id'] = this.jopsCategoryId;
    data['section'] = this.section;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
