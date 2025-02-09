// To parse this JSON data, do
//
//     final userSignInModel = userSignInModelFromJson(jsonString);

import 'dart:convert';

UserSignInModel userSignInModelFromJson(String str) =>
    UserSignInModel.fromJson(json.decode(str));

String userSignInModelToJson(UserSignInModel data) =>
    json.encode(data.toJson());

class UserSignInModel {
  String token;
  User user;

  UserSignInModel({
    required this.token,
    required this.user,
  });

  factory UserSignInModel.fromJson(Map<String, dynamic> json) =>
      UserSignInModel(
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
      };
}

class User {
  int id;
  String username;
  String email;

  User({
    required this.id,
    required this.username,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
      };
}
