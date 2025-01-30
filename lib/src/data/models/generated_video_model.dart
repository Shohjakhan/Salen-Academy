// To parse this JSON data, do
//
//     final generatedVideoModel = generatedVideoModelFromJson(jsonString);

import 'dart:convert';

GeneratedVideoModel generatedVideoModelFromJson(String str) =>
    GeneratedVideoModel.fromJson(json.decode(str));

String generatedVideoModelToJson(GeneratedVideoModel data) =>
    json.encode(data.toJson());

class GeneratedVideoModel {
  String videoLink;

  GeneratedVideoModel({
    required this.videoLink,
  });

  factory GeneratedVideoModel.fromJson(Map<String, dynamic> json) =>
      GeneratedVideoModel(
        videoLink: json["video_link"],
      );

  Map<String, dynamic> toJson() => {
        "video_link": videoLink,
      };
}
