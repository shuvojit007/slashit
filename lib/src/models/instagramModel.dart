import 'dart:convert';

InstagramModel instagramModelFromMap(String str) =>
    InstagramModel.fromMap(json.decode(str));
String instagramModelToMap(InstagramModel data) => json.encode(data.toMap());

class InstagramModel {
  InstagramModel({
    this.code,
    this.success,
    this.user,
  });
  String code;
  bool success;
  User user;

  factory InstagramModel.fromMap(Map<String, dynamic> json) => InstagramModel(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "success": success == null ? null : success,
        "user": user == null ? null : user.toMap(),
      };
}

class User {
  User({
    this.isInstagramVerified,
    this.instagram,
  });

  bool isInstagramVerified;
  String instagram;

  factory User.fromMap(Map<String, dynamic> json) => User(
        isInstagramVerified: json["isInstagramVerified"] == null
            ? null
            : json["isInstagramVerified"],
        instagram: json["instagram"] == null ? null : json["instagram"],
      );

  Map<String, dynamic> toMap() => {
        "isInstagramVerified":
            isInstagramVerified == null ? null : isInstagramVerified,
        "instagram": instagram == null ? null : instagram,
      };

  @override
  String toString() {
    return 'User{isInstagramVerified: $isInstagramVerified, instagram: $instagram}';
  }
}
