import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sens2/apps/samiya/controllers/fetch_controller.dart';
import 'package:sens2/apps/samiya/controllers/lote_controller.dart';
import 'package:sens2/core/controllers/table_controller.dart';
import 'package:sens2/core/services/api_client.dart';
import 'package:sens2/core/services/auth_service.dart';
import 'package:sens2/core/services/connectivity_service.dart';
import 'package:logger/logger.dart';

class RequestQueueService extends GetxService {
  final storage = GetStorage();
  final pendingRequests = <Map<String, dynamic>>[].obs;
  final AuthService authService = Get.put(AuthService());
  final Logger logger = Logger();
  final FetchController fetchController = Get.put(FetchController());

  var isProcessing = false.obs;

  static const String postMethod = "POST";
  static const String putMethod = "PUT";
  static const String deleteMethod = "DELETE";

  @override
  void onInit() {
    super.onInit();
    loadPendingRequests();
  }

  void loadPendingRequests() {
    final storedRequests = storage.read<List<dynamic>>('pendingRequests') ?? [];
    pendingRequests.assignAll(storedRequests.cast<Map<String, dynamic>>());
  }

  void addRequest(Map<String, dynamic> request) {
    pendingRequests.add(request);
    fetchController.pendingRequest.value = pendingRequests.length;
    storage.write('pendingRequests', pendingRequests);
  }

  void removeRequest(Map<String, dynamic> request) {
    pendingRequests.remove(request);
    storage.write('pendingRequests', pendingRequests);
    fetchController.pendingRequest.value = pendingRequests.length;
  }

  Future<void> processRequests() async {
    if (isProcessing.value) {
      logger.w("Ya se está procesando la cola de solicitudes.");
      return;
    }

    isProcessing.value = true;
    fetchController.pendingRequest.value = pendingRequests.length;

    try {
      var connectivityService = Get.find<ConnectivityService>();
      await connectivityService.checkInternetAccess();

      if (connectivityService.isOnline.value) {
        final apiClient = Get.find<ApiClient>();

        // Iterar sobre una copia para evitar conflictos al modificar la lista
        for (var request in List<Map<String, dynamic>>.from(pendingRequests)) {

          if (request["is_processing"] == false) {
            // Marcar la solicitud como en proceso
            request["is_processing"] = true;
            updateRequestInStorage(request);


            try {
              if (_hasValidToken(request)) {
                apiClient.setToken(request['token']);
              }

              var response;
              switch (request['method']) {
                case postMethod:
                  response = await handlePostRequest(apiClient, request);
                  break;
                case putMethod:
                  response = await handlePutRequest(apiClient, request);
                  break;
                case deleteMethod:
                  response = await handleDeleteRequest(apiClient, request);
                  break;
                default:
                  logger.e("Método no soportado: ${request['method']}");
              }

              logger.i("Resultado del request: ${response.body}");
              await handleResponse(response, request);
            } catch (e) {
              if (e is CustomApiException) {
                if (e.statusCode == 401) {
                  final success = await _attemptReLogin();
                  if (success) {
                    await processRequests();
                  } else {
                    logger.w("Re-login fallido. La solicitud permanecerá en la cola.");
                  }
                } else {
                  logger.e("Error de API: ${e.message}, Código de estado: ${e.statusCode}");
                  Get.snackbar(
                      'Error de API',
                      "${e.message} (Código de estado: ${e.statusCode})"
                  );
                  // Opcional: Restablecer is_processing a false si deseas reintentar
                  request["is_processing"] = false;
                  updateRequestInStorage(request);
                }
              } else {
                logger.e("Error desconocido: $e");
                Get.snackbar('Error', "Error procesando la solicitud: $e");
                // Opcional: Restablecer is_processing a false si deseas reintentar
                request["is_processing"] = false;
                updateRequestInStorage(request);
              }
            }
          }
        }
      } else {
        Get.snackbar('Error', "No se detecta conexión a internet.");
      }
    } catch (e) {
      logger.e("Error al procesar solicitudes: $e");
    } finally {
      isProcessing.value = false;
      fetchController.pendingRequest.value = pendingRequests.length;
    }
  }

  void updateRequestInStorage(Map<String, dynamic> request) {
    int index = pendingRequests.indexWhere((item) => item['id'] == request['id']);
    if (index != -1) {
      pendingRequests[index] = request;
      storage.write('pendingRequests', pendingRequests);
      pendingRequests.refresh();
    }
  }

  Future<void> handleResponse(
      dynamic response, Map<String, dynamic> request) async {
    if (response != null && response.statusCode == 200) {
      removeRequest(request);
    } else if (response?.statusCode == 401) {
      final success = await _attemptReLogin();
      if (success) {
        await processRequests();
      } else {
        logger.w("Re-login failed. Request will remain in the queue.");
      }
    }
  }

  bool _hasValidToken(Map<String, dynamic> request) {
    return request.containsKey('token') &&
        request['token'] != null &&
        request['token'].isNotEmpty;
  }

  Future<dynamic> handlePostRequest(
      ApiClient apiClient, Map<String, dynamic> request) async {
    final response = await apiClient.post(
      request['endpoint'],
      body: jsonEncode(request['body']),
    );

    if (response.statusCode != 200) {
      throw CustomApiException(
        'Failed request to ${request['endpoint']} with status code: ${response.statusCode}',
        response.statusCode,
      );
    }

    if (request['module'] == "table") {
      final tableController = Get.find<TableController>();
      final currentItem = jsonDecode(response.body);

      int index = tableController.filteredData
          .indexWhere((item) => item['id'] == request["body"]["id"]);

      if (index != -1) {

        tableController.filteredData[index]["id"] =
            currentItem["data"]["doc_id"];
      /*  tableController.setItemAfterCreate(
            index, tableController.filteredData[index]);
        logger.i(
            "Updated table data for item: ${tableController.filteredData[index]}");*/

        tableController.updateArray(tableController.filteredData);
      }
    }

    if (request['module'] == "lote") {
      final loteController = Get.find<LoteController>();
      loteController.fetchLotes();
    }


    return response;
  }

  Future<dynamic> handlePutRequest(
      ApiClient apiClient, Map<String, dynamic> request) async {
    final response = await apiClient.put(
      request['endpoint'],
      body: jsonEncode(request['body']),
    );

    if (response.statusCode != 200) {
      throw CustomApiException(
        'Failed PUT request to ${request['endpoint']} with status code: ${response.statusCode}',
        response.statusCode,
      );
    }

    return response;
  }

  Future<dynamic> handleDeleteRequest(
      ApiClient apiClient, Map<String, dynamic> request) async {
    final body = request['body'];
    final response;

    if (body != null && body.isNotEmpty) {
      logger.i("Deleting data at ${request['endpoint']} with body: $body");
      response = await apiClient.delete(
        request['endpoint'],
        body: body,
      );
    } else {
      response = await apiClient.delete(
        request['endpoint'],
      );
    }

    if (response.statusCode != 200) {
      throw CustomApiException(
        'Failed DELETE request to ${request['endpoint']} with status code: ${response.statusCode}',
        response.statusCode,
      );
    }

    return response;
  }

  Future<bool> _attemptReLogin() async {
    try {
      final username = storage.read('username');
      final password = storage.read('password');
      if (username != null && password != null) {
        await authService.login(username, password);
        return true;
      }
    } catch (e) {
      logger.e("Re-login failed: $e");
    }
    return false;
  }
}

class CustomApiException implements Exception {
  final String message;
  final int statusCode;

  CustomApiException(this.message, this.statusCode);

  @override
  String toString() =>
      'CustomApiException: $message (Status code: $statusCode)';
}
