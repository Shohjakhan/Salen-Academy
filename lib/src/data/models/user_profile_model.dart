class UserProfileModel {
  final String id;
  final String email;
  final String fullName;
  final int dailyQuotaUsed;
  final bool isActive;
  final DateTime dateJoined;
  final Statistics? statistics;

  UserProfileModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.dailyQuotaUsed,
    required this.isActive,
    required this.dateJoined,
    this.statistics,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        id: json["id"],
        email: json["email"],
        fullName: json["full_name"],
        dailyQuotaUsed: json["daily_quota_used"],
        isActive: json["is_active"],
        dateJoined: DateTime.parse(json["date_joined"]),
        statistics: json["statistics"] == null
            ? null
            : Statistics.fromJson(json["statistics"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "full_name": fullName,
        "daily_quota_used": dailyQuotaUsed,
        "is_active": isActive,
        "date_joined": dateJoined.toIso8601String(),
        "statistics": statistics?.toJson(),
      };
}

class Statistics {
  final int totalSessions;
  final int completedSessions;
  final int successRate;
  final int dailyQuotaUsed;
  final int dailyQuotaRemaining;

  Statistics({
    required this.totalSessions,
    required this.completedSessions,
    required this.successRate,
    required this.dailyQuotaUsed,
    required this.dailyQuotaRemaining,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        totalSessions: json["total_sessions"],
        completedSessions: json["completed_sessions"],
        successRate: json["success_rate"],
        dailyQuotaUsed: json["daily_quota_used"],
        dailyQuotaRemaining: json["daily_quota_remaining"],
      );

  Map<String, dynamic> toJson() => {
        "total_sessions": totalSessions,
        "completed_sessions": completedSessions,
        "success_rate": successRate,
        "daily_quota_used": dailyQuotaUsed,
        "daily_quota_remaining": dailyQuotaRemaining,
      };
}
