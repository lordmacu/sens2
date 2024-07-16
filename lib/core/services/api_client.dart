import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiClient extends GetxService {
  late http.Client httpClient;
  late String baseUrl;
  var token = ''.obs;

  @override
  void onInit() {
    httpClient = http.Client();
    super.onInit();
  }

  void setBaseUrl(String url) {
    baseUrl = url;
  }

  void setToken(String newToken) {
    token.value = newToken;
  }

  Uri _getUri(String endpoint) {
    return Uri.parse('$baseUrl$endpoint');
  }

  Future<http.Response> get(String endpoint,
      {Map<String, String>? headers}) async {
    final combinedHeaders = {
      'Authorization': 'Bearer ${token.value}',
      if (headers != null) ...headers,
    };
    return await httpClient.get(_getUri(endpoint), headers: combinedHeaders);
  }

  Future<http.Response> post(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    final combinedHeaders = {
      'Authorization': 'Bearer ${token.value}',
      'Content-Type': 'application/json',
      if (headers != null) ...headers,
    };
    return await httpClient.post(
      _getUri(endpoint),
      headers: combinedHeaders,
      body: body,
    );
  }

  Future<http.Response> put(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    final combinedHeaders = {
      'Authorization': 'Bearer ${token.value}',
      'Content-Type': 'application/json',
      if (headers != null) ...headers,
    };
    return await httpClient.put(
      _getUri(endpoint),
      headers: combinedHeaders,
      body: body,
    );
  }

  Future<http.Response> delete(String endpoint,
      {Map<String, String>? headers}) async {
    final combinedHeaders = {
      'Authorization': 'Bearer ${token.value}',
      if (headers != null) ...headers,
    };
    return await httpClient.delete(_getUri(endpoint), headers: combinedHeaders);
  }
}
