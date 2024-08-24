import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sens2/core/services/api_client.dart';
import 'package:sens2/core/services/auth_service.dart';
import 'package:sens2/core/services/connectivity_service.dart';
import 'package:logger/logger.dart';

class RequestQueueService extends GetxService {
  final storage = GetStorage();
  final pendingRequests = <Map<String, dynamic>>[].obs;
  final AuthService authService = Get.put(AuthService());
  final Logger logger = Logger();

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
    storage.write('pendingRequests', pendingRequests);
  }

  void removeRequest(Map<String, dynamic> request) {
    pendingRequests.remove(request);
    storage.write('pendingRequests', pendingRequests);
  }

  Future<void> processRequests() async {
    if (Get.find<ConnectivityService>().isOnline.value) {
      for (var request in List.from(pendingRequests)) {
        logger.i("Processing request: $request");
        try {
          final response = await Get.find<ApiClient>().post(
            request['endpoint'],
            body: jsonEncode(request['body']),
          );

          if (response.statusCode == 200) {
            removeRequest(request);
          } else if (response.statusCode == 401) {
            final success = await _attemptReLogin();
            if (success) {
              await processRequests();
              return; // Exit the loop as the requests will be re-processed
            } else {
              logger.w("Re-login failed. Request will remain in the queue.");
            }
          }
        } catch (e) {
          logger.e("Error processing request: $e");
        }
      }
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