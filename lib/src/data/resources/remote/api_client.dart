import '../../../services/api_client/impl/api_service.dart';
import 'api_exceptions/api_exceptions.dart';

class ApiClient {
  late final String _baseUrl;
  late final ApiService _apiService;

  ApiClient({required ApiService apiService, required String baseUrl}) {
    _apiService = apiService;
    _baseUrl = baseUrl;
  }

  Map<String, String> _getHeaders(Map<String, String>? header) {
    final requestHeader = header ?? {};
    // final accessToken = LocalDataRepository.getAccessTokenSync();

    // if (accessToken.isNotEmpty) {
    //   requestHeader.addAll({'Authorization': 'Bearer $accessToken'});
    // }

    requestHeader.addAll({
      'Content-Type': 'application/json; charset=UTF-8',
    });

    return requestHeader;
  }

  Future<Map<String, dynamic>> request(
    String urlEndPoint, {
    String method = "GET",
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    final requestHeader = _getHeaders(headers);

    try {
      switch (method) {
        case 'GET':
          return await _getRequest(
            urlEndPoint: urlEndPoint,
            headers: requestHeader,
          );
        case 'POST':
          return await _postRequest(
            urlEndPoint: urlEndPoint,
            headers: requestHeader,
            body: body,
          );
        case 'PUT':
          return await _putRequest(
            urlEndPoint: urlEndPoint,
            headers: requestHeader,
            body: body,
          );
        case 'DELETE':
          return await _deleteRequest(
            urlEndPoint: urlEndPoint,
            headers: requestHeader,
          );
        default:
          throw ApiException(
            body: {
              'success': false,
              'error': {
                'errId': 0,
                'errMsg': 'No such method',
              }
            },
            url: urlEndPoint,
            statusCode: 0,
          );
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw throw ApiException(
        body: {
          'success': false,
          'error': {
            'errId': 0,
            'errMsg': e.toString(),
          }
        },
        url: urlEndPoint,
        statusCode: 0,
      );
    }
  }

  Future<Map<String, dynamic>> _getRequest({
    required String urlEndPoint,
    required Map<String, String> headers,
  }) async {
    return await _apiService.request(
      url: '$_baseUrl$urlEndPoint',
      method: 'GET',
      headers: headers,
    );
  }

  Future<Map<String, dynamic>> _deleteRequest({
    required String urlEndPoint,
    required Map<String, String> headers,
  }) async {
    return await _apiService.request(
      url: '$_baseUrl$urlEndPoint',
      method: 'DELETE',
      headers: headers,
    );
  }

  Future<Map<String, dynamic>> _postRequest({
    required String urlEndPoint,
    required Map<String, String> headers,
    required Map<String, dynamic>? body,
  }) async {
    return await _apiService.request(
      url: '$_baseUrl$urlEndPoint',
      method: 'POST',
      headers: headers,
      body: body,
    );
  }

  Future<Map<String, dynamic>> _putRequest({
    required String urlEndPoint,
    required Map<String, String> headers,
    required Map<String, dynamic>? body,
  }) async {
    return await _apiService.request(
      url: '$_baseUrl$urlEndPoint',
      method: 'PUT',
      headers: headers,
      body: body,
    );
  }
}
