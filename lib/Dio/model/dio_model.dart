// To parse this JSON data, do
//
//     final dioproject = dioprojectFromJson(jsonString);

import 'dart:convert';

List<Dioproject> dioprojectFromJson(String str) => List<Dioproject>.from(json.decode(str).map((x) => Dioproject.fromJson(x)));

String dioprojectToJson(List<Dioproject> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Dioproject {
  int userId;
  int id;
  String title;
  String body;

  Dioproject({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Dioproject.fromJson(Map<String, dynamic> json) => Dioproject(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}
