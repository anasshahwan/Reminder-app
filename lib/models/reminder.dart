import 'package:json_annotation/json_annotation.dart';
@JsonSerializable(nullable: false)

class Reminder {
  String id;
  String title;
  String body;
  Reminder({this.title,this.body,this.id});


  factory Reminder.fromMap(Map<String, dynamic> json) => new Reminder(
    id: json['id'],
    title: json["title"],
    body: json["body"],

  );
  Map<String, dynamic> toJson() => {
    'id':id,
    "title": title,
    "body": body,

  };
}