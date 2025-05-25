// To parse this JSON data, do
//
//     final userSignInModel = userSignInModelFromJson(jsonString);

import 'dart:convert';

import 'user_model.dart';

UserSignUpModel userSignUpModelFromJson(String str) =>
    UserSignUpModel.fromJson(json.decode(str));

String userSignUpModelToJson(UserSignUpModel data) =>
    json.encode(data.toJson());

class UserSignUpModel {
  String token;
  UserModel user;

  UserSignUpModel({
    required this.token,
    required this.user,
  });

  factory UserSignUpModel.fromJson(Map<String, dynamic> json) =>
      UserSignUpModel(
        token: json["token"],
        user: UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
      };
}
