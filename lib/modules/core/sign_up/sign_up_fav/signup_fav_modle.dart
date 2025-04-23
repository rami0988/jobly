
//add fav
class AddFav {
  bool? status;
  String? message;
  Data? data;

  AddFav({this.status, this.message, this.data});

  AddFav.fromJson(Map<String, dynamic> json) {
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
  int? employeeId;
  String? jopsSectionId;

  Data({this.employeeId, this.jopsSectionId});

  Data.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    jopsSectionId = json['jops_section_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_id'] = this.employeeId;
    data['jops_section_id'] = this.jopsSectionId;
    return data;
  }
}



