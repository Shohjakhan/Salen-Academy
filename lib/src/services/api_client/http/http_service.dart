import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../core/logger.dart';
import '../../../data/resources/remote/api_exceptions/api_exceptions.dart';
import '../impl/api_service.dart';

class HttpService implements ApiService {
  final _client = http.Client();

  @override
  Future<Map<String, dynamic>> request({
    required String url,
    required String method,
    required Map<String, String> headers,
    Map<String, dynamic>? body,
  }) async {
    var uri = Uri.parse(url);

    http.Response response;
    try {
      switch (method) {
        case 'GET':
          response = await _getRequest(uri: uri, headers: headers);
          break;
        case 'POST':
          response = await _postRequest(uri: uri, headers: headers, body: body);
          break;
        case 'PUT':
          response = await _putRequest(uri: uri, headers: headers, body: body);
          break;
        case 'DELETE':
          response = await _deleteRequest(uri: uri, headers: headers);
        default:
          throw ApiException(
            body: {'message': 'No such http method'},
            statusCode: 0,
            url: url,
          );
      }

      logger.i(
        '${response.request} ${response.statusCode}\n$headers\n$body\n${response.body}',
      );

      if (response.statusCode == 401) {
        //TODO: refresh token;
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      }

      throw ApiException(
        body: jsonDecode(response.body),
        statusCode: response.statusCode,
        url: url,
      );
    } on http.ClientException catch (error) {
      throw ApiException(
        body: jsonDecode(error.message),
        statusCode: 404,
        url: url,
      );
    } catch (e) {
      logger.e(
        '$method $url\n$headers\n$body\n$e',
      );

      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> uploadFiles({
    required String url,
    required Map<String, String> headers,
    required Map<String, String> body,
    required File? file,
    required Function(double progress) onProgress,
  }) async {
    var uri = Uri.parse(url);
    try {
      final request = MultipartRequest(
        'POST',
        uri,
        onProgress: (int bytes, int total) {
          final progress = bytes / total;
          onProgress(progress);
        },
      );

      request.headers.addAll(headers);
      request.fields.addAll(body);

      if (file != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            file.path,
            filename: file.path.split('/').last,
          ),
        );
      }

      final streamedResponse = await request.send();
      final respStr = await streamedResponse.stream.bytesToString();
      return jsonDecode(respStr);
    } catch (e) {
      logger.e(e);
    }

    return {};
  }

  Future<http.Response> _getRequest({
    required Uri uri,
    required Map<String, String>? headers,
  }) async {
    return await _client.get(uri, headers: headers);
  }

  Future<http.Response> _postRequest({
    required Uri uri,
    required Map<String, String>? headers,
    required Map<String, dynamic>? body,
  }) async {
    return await _client.post(uri, headers: headers, body: jsonEncode(body));
  }

  Future<http.Response> _putRequest({
    required Uri uri,
    required Map<String, String>? headers,
    required Map<String, dynamic>? body,
  }) async {
    return await _client.put(uri, headers: headers, body: jsonEncode(body));
  }

  Future<http.Response> _deleteRequest({
    required Uri uri,
    required Map<String, String>? headers,
  }) async {
    return await _client.delete(uri, headers: headers);
  }
}

class MultipartRequest extends http.MultipartRequest {
  /// Creates a new [MultipartRequest].
  MultipartRequest(
    super.method,
    super.url, {
    required this.onProgress,
  });

  final void Function(int bytes, int totalBytes) onProgress;

  /// Freezes all mutable fields and returns a single-subscription [ByteStream]
  /// that will emit the request body.
  @override
  http.ByteStream finalize() {
    final byteStream = super.finalize();

    final total = contentLength;
    int bytes = 0;

    final t = StreamTransformer.fromHandlers(
      handleData: (List<int> data, EventSink<List<int>> sink) {
        bytes += data.length;
        onProgress(bytes, total);
        if (total >= bytes) {
          sink.add(data);
        }
      },
    );
    final stream = byteStream.transform(t);
    return http.ByteStream(stream);
  }
}
