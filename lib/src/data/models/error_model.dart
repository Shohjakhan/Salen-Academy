class ErrorModel {
  final int errorId;
  final bool isFriendly;
  final String message;

  ErrorModel({
    required this.errorId,
    required this.isFriendly,
    required this.message,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        errorId: json["errId"],
        message: json["errMsg"],
        isFriendly: true,
      );
}
