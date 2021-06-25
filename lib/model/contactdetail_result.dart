// To parse this JSON data, do
//
//     final contactdetailResult = contactdetailResultFromJson(jsonString);

import 'dart:convert';

ContactdetailResult contactdetailResultFromJson(String str) => ContactdetailResult.fromJson(json.decode(str));

String contactdetailResultToJson(ContactdetailResult data) => json.encode(data.toJson());

class ContactdetailResult {
  ContactdetailResult({
    this.data,
    this.support,
  });

  Data data;
  Support support;

  factory ContactdetailResult.fromJson(Map<String, dynamic> json) => ContactdetailResult(
    data: Data.fromJson(json["data"]),
    support: Support.fromJson(json["support"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "support": support.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "avatar": avatar,
  };
}

class Support {
  Support({
    this.url,
    this.text,
  });

  String url;
  String text;

  factory Support.fromJson(Map<String, dynamic> json) => Support(
    url: json["url"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "text": text,
  };
}
