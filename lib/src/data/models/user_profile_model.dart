class UserProfileModel {
  final String id;
  final String email;
  final String username;
  final String fullName;
  final String firstName;
  final String lastName;
  final int dailyQuotaUsed;
  final bool isActive;
  final DateTime dateJoined;

  UserProfileModel({
    required this.id,
    required this.email,
    required this.username,
    required this.fullName,
    required this.firstName,
    required this.lastName,
    required this.dailyQuotaUsed,
    required this.isActive,
    required this.dateJoined,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        id: json["id"],
        email: json["email"],
        username: json["username"],
        fullName: json["full_name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        dailyQuotaUsed: json["daily_quota_used"],
        isActive: json["is_active"],
        dateJoined: DateTime.parse(json["date_joined"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "username": username,
        "full_name": fullName,
        "first_name": firstName,
        "last_name": lastName,
        "daily_quota_used": dailyQuotaUsed,
        "is_active": isActive,
        "date_joined": dateJoined.toIso8601String(),
      };
}
