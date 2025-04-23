// To parse this JSON data, do
//
//     final companyProfileModel = companyProfileModelFromJson(jsonString);

import 'dart:convert';

CompanyProfileModel companyProfileModelFromJson(String str) => CompanyProfileModel.fromJson(json.decode(str));

String companyProfileModelToJson(CompanyProfileModel data) => json.encode(data.toJson());

class CompanyProfileModel {
    bool status;
    String message;
    Data data;

    CompanyProfileModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory CompanyProfileModel.fromJson(Map<String, dynamic> json) => CompanyProfileModel(
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
    DateTime dateOfEstablishment;
    int employeNumber;
    String commercialRecord;
    String companyName;
    String contactPhone;
    String industry;
    String companyDescription;
    String companyWebsite;
    String contactEmail;
    String contactPerson;
    DateTime createdAt;
    DateTime updatedAt;
    Address address;
    String avg;
    List<Rating> ratings;

    Data({
        required this.id,
        required this.userId,
        required this.dateOfEstablishment,
        required this.employeNumber,
        required this.commercialRecord,
        required this.companyName,
        required this.contactPhone,
        required this.industry,
        required this.companyDescription,
        required this.companyWebsite,
        required this.contactEmail,
        required this.contactPerson,
        required this.createdAt,
        required this.updatedAt,
        required this.address,
        required this.avg,
        required this.ratings,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        dateOfEstablishment: DateTime.parse(json["Date_of_Establishment"]),
        employeNumber: json["employe_number"],
        commercialRecord: json["Commercial_Record"],
        companyName: json["company_name"],
        contactPhone: json["contact_phone"],
        industry: json["industry"],
        companyDescription: json["company_description"],
        companyWebsite: json["company_website"],
        contactEmail: json["contact_email"],
        contactPerson: json["contact_person"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        address: Address.fromJson(json["address"]),
        avg: json["avg"],
        ratings: List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "Date_of_Establishment": "${dateOfEstablishment.year.toString().padLeft(4, '0')}-${dateOfEstablishment.month.toString().padLeft(2, '0')}-${dateOfEstablishment.day.toString().padLeft(2, '0')}",
        "employe_number": employeNumber,
        "Commercial_Record": commercialRecord,
        "company_name": companyName,
        "contact_phone": contactPhone,
        "industry": industry,
        "company_description": companyDescription,
        "company_website": companyWebsite,
        "contact_email": contactEmail,
        "contact_person": contactPerson,
        "avg": avg,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "address": address.toJson(),
        "ratings": List<dynamic>.from(ratings.map((x) => x.toJson())),
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

class Rating {
    int id;
    int companyId;
    int employeeId;
    String rating;
    String comment;
    DateTime createdAt;
    DateTime updatedAt;

    Rating({
        required this.id,
        required this.companyId,
        required this.employeeId,
        required this.rating,
        required this.comment,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        id: json["id"],
        companyId: json["company_id"],
        employeeId: json["employee_id"],
        rating: json["rating"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "employee_id": employeeId,
        "rating": rating,
        "comment": comment,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

///response
/* 
{
    "status": true,
    "message": "success",
    "data": {
        "id": 1,
        "user_id": 12,
       x "Date_of_Establishment": "2023-01-02",
        "employe_number": 309,
       x "Commercial_Record": "company.jpg",
       x "company_name": "Flatley Group",
       x "contact_phone": "+17249123405",
       x "industry": "autem",
       x "company_description": "Sunt qui natus quisquam. Ullam et quibusdam ea. Tenetur esse optio recusandae beatae consequatur ut velit. Consectetur minima quibusdam facere consequatur.",
        x"company_website": "http://www.deckow.net/libero-quasi-explicabo-dignissimos-id-beatae-sed-voluptates",
       x "contact_email": "melyssa57@lesch.com",
        "contact_person": "Jazmyn Larson",
      x  "created_at": "2024-07-02T16:19:15.000000Z",
      x  "updated_at": "2024-07-02T16:19:15.000000Z",
        "address": {
            "id": 12,
            "user_id": 12,
            "county": "Virginia",
            "city": "Schroederhaven",
            "Governorate": "New Hampshire",
            "created_at": "2024-07-02T16:19:15.000000Z",
            "updated_at": "2024-07-02T16:19:15.000000Z"
        },
       x "ratings": []
    }
}
*/