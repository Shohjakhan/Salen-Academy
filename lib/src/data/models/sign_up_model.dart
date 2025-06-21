// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

import 'user_profile_model.dart';

SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  final bool success;
  final String message;
  final Tokens tokens;
  final UserProfileModel userProfile;

  SignUpModel({
    required this.success,
    required this.message,
    required this.tokens,
    required this.userProfile,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        success: json["success"],
        message: json["message"],
        tokens: Tokens.fromJson(json["tokens"]),
        userProfile: UserProfileModel.fromJson(json["user_profile"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "tokens": tokens.toJson(),
        "user_profile": userProfile.toJson(),
      };
}

class Tokens {
  final String access;
  final String refresh;

  Tokens({
    required this.access,
    required this.refresh,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        access: json["access"],
        refresh: json["refresh"],
      );

  Map<String, dynamic> toJson() => {
        "access": access,
        "refresh": refresh,
      };
}
