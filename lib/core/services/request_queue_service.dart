import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sens2/apps/samiya/controllers/fetch_controller.dart';
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
  }

  Future<void> processRequests() async {
    if (Get.find<ConnectivityService>().isOnline.value) {
      isProcessing.value = true;
      final apiClient = Get.find<ApiClient>();

      for (var request in List.from(pendingRequests)) {
        logger.i("Processing request: $request");

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
              logger.e("Unsupported method: ${request['method']}");
          }

          await handleResponse(response, request);
        } catch (e) {
          logger.e("Error processing request: $e");
        }
      }

      isProcessing.value = false;
      fetchController.pendingRequest.value = pendingRequests.length;
    }
  }

  Future<void> handleResponse(dynamic response, Map<String, dynamic> request) async {
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

  Future<dynamic> handlePostRequest(ApiClient apiClient, Map<String, dynamic> request) async {
    final response = await apiClient.post(
      request['endpoint'],
      body: jsonEncode(request['body']),
    );

    if (request['module'] == "table") {
      final tableController = Get.find<TableController>();
      final currentItem = jsonDecode(response.body);

      int index = tableController.filteredData.indexWhere((item) =>
      item['id'] == request["body"]["id"]);

      if (index != -1) {
        tableController.filteredData[index]["id"] = currentItem["data"]["doc_id"];
        tableController.setItemAfterCreate(index, tableController.filteredData[index]);
        logger.i("Updated table data for item: ${tableController.filteredData[index]}");
      }
    }

    return response;
  }

  Future<dynamic> handlePutRequest(ApiClient apiClient, Map<String, dynamic> request) async {
    return await apiClient.put(
      request['endpoint'],
      body: jsonEncode(request['body']),
    );
  }

  Future<dynamic> handleDeleteRequest(ApiClient apiClient, Map<String, dynamic> request) async {
    final body = request['body'];
    if (body != null && body.isNotEmpty) {
      logger.i("Deleting data at ${request['endpoint']} with body: $body");
      return await apiClient.delete(
        request['endpoint'],
        body: body,
      );
    } else {
      return await apiClient.delete(
        request['endpoint'],
      );
    }
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
