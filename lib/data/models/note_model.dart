
import 'dart:convert';

class Note {
    final String id;
    final String title;
    final String body;
    final DateTime createdAt;

    Note({
        required this.id,
        required this.title,
        required this.body,
        required this.createdAt,
    });

    factory Note.fromRawJson(String str) => Note.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["id"].toString(),
        title: json["title"],
        body: json["body"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "createdAt": createdAt.toIso8601String(),
    };
}
