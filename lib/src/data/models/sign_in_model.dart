// To parse this JSON data, do
//
//     final userSignInModel = userSignInModelFromJson(jsonString);

import 'dart:convert';

SignInModel signInModelFromJson(String str) =>
    SignInModel.fromJson(json.decode(str));

String signInModelToJson(SignInModel data) => json.encode(data.toJson());

class SignInModel {
  String token;

  SignInModel({
    required this.token,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
