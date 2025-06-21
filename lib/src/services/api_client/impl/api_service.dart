import 'dart:io';

abstract class ApiService {
  Future<Map<String, dynamic>> uploadFiles({
    required String url,
    required Map<String, String> headers,
    required Map<String, String> body,
    required File? file,
    required Function(double progress) onProgress,
  });

  Future<Map<String, dynamic>> request({
    required String url,
    required String method,
    required Map<String, String> headers,
    Map<String, dynamic>? body,
  });
}
