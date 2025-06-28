class Owner {
  String? login;
  int? id;
  String? avatarUrl;

  Owner({this.login, this.id, this.avatarUrl});

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
    login: json["login"],
    id: json["id"],
    avatarUrl: json["avatar_url"],
  );

  Map<String, dynamic> toJson() => {
    "login": login,
    "id": id,
    "avatar_url": avatarUrl,
  };
}
