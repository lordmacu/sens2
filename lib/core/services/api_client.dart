import 'dart:convert';

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
      {Map<String, String>? headers, Map<String, dynamic>? body}) async {

    final combinedHeaders = {
      'access-token': token.value,
      'Content-Type': 'application/json', // Especifica que estás enviando JSON
      if (headers != null) ...headers,
    };

    logger.i("Requesting GET $endpoint with headers $combinedHeaders ${_getUri(endpoint)}");

    // Crear la solicitud HTTP personalizada
    final request = http.Request('GET', _getUri(endpoint))
      ..headers.addAll(combinedHeaders);

    // Si se proporciona un cuerpo, agréguelo a la solicitud
    if (body != null) {
      request.body = jsonEncode(body);
    }

    // Envía la solicitud personalizada
    final streamedResponse = await httpClient.send(request);

    // Convierte el StreamedResponse a una instancia de Response
    return await http.Response.fromStream(streamedResponse);
  }


  Future<http.Response> post(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    final combinedHeaders = {
      'access-token': token.value,
      'Content-Type': 'application/json',
      if (headers != null) ...headers,
    };

    logger.i("estos son los headers ${_getUri(endpoint)} $combinedHeaders"); // Reemplazo de print
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
      {Map<String, String>? headers, Map<String, dynamic>? body}) async {
    final combinedHeaders = {
      'access-token': token.value,
      'Content-Type': 'application/json', // Ensure the content type is JSON
      if (headers != null) ...headers,
    };

    logger.i("Requesting DELETE $endpoint with headers $combinedHeaders ${_getUri(endpoint)}");

    // Create the custom HTTP request
    final request = http.Request('DELETE', _getUri(endpoint))
      ..headers.addAll(combinedHeaders);

    // If a body is provided, add it to the request
    if (body != null) {
      request.body = jsonEncode(body);
    }

    // Send the custom request
    final streamedResponse = await httpClient.send(request);

    // Convert the StreamedResponse to an instance of Response
    return await http.Response.fromStream(streamedResponse);
  }

}