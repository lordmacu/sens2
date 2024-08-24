import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ApiClient extends GetxService {
  late http.Client httpClient;
  late String baseUrl;
  var token = ''.obs;

  final Logger logger = Logger(); // Instancia del logger

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
      'access-token': token.value,
      if (headers != null) ...headers,
    };

    return await httpClient.get(_getUri(endpoint), headers: combinedHeaders);
  }

  Future<http.Response> post(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    final combinedHeaders = {
      'access-token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNhbWl5YXRlc3RlckBzZW5zY2xvdWQuaW8iLCJ1c2VyX2lkIjoiNjM5YjYzNzQ2MjllN2JjYjlmYjRiMzhiIiwiZW5hYmxlIjp0cnVlLCJpYXQiOjE3MjQxNjA2MzMsImV4cCI6MTcyNDc2NTQzM30.t3bRYvWQPgosbVX3ClnCidLlFyc7vlllisBpW4aHqzY',
      'Content-Type': 'application/json',
      if (headers != null) ...headers,
    };

    logger.i("estos son los headers $combinedHeaders"); // Reemplazo de print
    return await httpClient.post(
      _getUri(endpoint),
      headers: combinedHeaders,
      body: body,
    );
  }

  Future<http.Response> put(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    final combinedHeaders = {
      'access-token': token.value,
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
      'Authorization': token.value,
      if (headers != null) ...headers,
    };
    return await httpClient.delete(_getUri(endpoint), headers: combinedHeaders);
  }
}