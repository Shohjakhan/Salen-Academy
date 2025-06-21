// To parse this JSON data, do
//
//     final signInModel = signInModelFromJson(jsonString);

import 'dart:convert';

import 'user_profile_model.dart';

SignInModel signInModelFromJson(String str) =>
    SignInModel.fromJson(json.decode(str));

String signInModelToJson(SignInModel data) => json.encode(data.toJson());

class SignInModel {
  final String access;
  final String refresh;
  final User user;
  final UserProfileModel userProfile;

  SignInModel({
    required this.access,
    required this.refresh,
    required this.user,
    required this.userProfile,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
        access: json["access"],
        refresh: json["refresh"],
        user: User.fromJson(json["user"]),
        userProfile: UserProfileModel.fromJson(json["user_profile"]),
      );

  Map<String, dynamic> toJson() => {
        "access": access,
        "refresh": refresh,
        "user": user.toJson(),
        "user_profile": userProfile.toJson(),
      };
}

class User {
  final String id;
  final String email;
  final String fullName;
  final int dailyQuotaUsed;

  User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.dailyQuotaUsed,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        fullName: json["full_name"],
        dailyQuotaUsed: json["daily_quota_used"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "full_name": fullName,
        "daily_quota_used": dailyQuotaUsed,
      };
}
