import 'dart:convert';

List<VideoModel> videosFromJson(String str) =>
    List<VideoModel>.from(json.decode(str).map((x) => VideoModel.fromJson(x)));

String videosToJson(List<VideoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VideoModel {
  int id;
  String prompt;
  String status;
  String quality;
  String language;
  String videoUrl;
  DateTime createdAt;

  VideoModel({
    required this.id,
    required this.prompt,
    required this.status,
    required this.quality,
    required this.language,
    required this.videoUrl,
    required this.createdAt,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        id: json["id"],
        prompt: json["prompt"],
        status: json["status"],
        quality: json["quality"],
        language: json["language"],
        videoUrl: json["video_url"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "prompt": prompt,
        "status": status,
        "quality": quality,
        "language": language,
        "video_url": videoUrl,
        "created_at": createdAt.toIso8601String(),
      };
}
