// To parse this JSON data, do
//
//     final userSignInModel = userSignInModelFromJson(jsonString);

import 'dart:convert';

import 'user_model.dart';

SignInModel signInModelFromJson(String str) =>
    SignInModel.fromJson(json.decode(str));

String signInModelToJson(SignInModel data) => json.encode(data.toJson());

class SignInModel {
  String token;
  UserModel user;

  SignInModel({
    required this.token,
    required this.user,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
        token: json["token"],
        user: UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
      };
}
