import 'package:flutter_task/features/home/data/model/pogo_model/Owner_model.dart';

class Item {
  int? id;
  String? name;
  String? fullName;
  Owner? owner;
  String? htmlUrl;
  String? description;
  int? stargazersCount;
  int? watchersCount;
  DateTime? createdAt;
  DateTime? updatedAt;

  String? language;

  Item({
    this.id,
    this.name,
    this.fullName,
    this.owner,
    this.htmlUrl,
    this.description,
    this.stargazersCount,
    this.watchersCount,
    this.createdAt,
    this.updatedAt,
    this.language,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    name: json["name"],
    fullName: json["full_name"],
    owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
    htmlUrl: json["html_url"],
    description: json["description"],
    stargazersCount: json["stargazers_count"],
    watchersCount: json["watchers_count"],
    createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    language: json["language"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "full_name": fullName,
    "owner": owner?.toJson(),
    "html_url": htmlUrl,
    "description": description,
    "stargazers_count": stargazersCount,
    "watchers_count": watchersCount,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "language": language,
  };
}
