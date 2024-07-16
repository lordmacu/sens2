import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sens2/core/services/api_client.dart';
import 'package:sens2/core/services/connectivity_service.dart';

class RequestQueueService extends GetxService {
  final storage = GetStorage();
  final pendingRequests = <Map<String, dynamic>>[].obs;

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
      for (var request in pendingRequests) {
        try {
          // Procesar cada petición
          final response = await Get.find<ApiClient>().post(
            request['endpoint'],
            body: request['body'],
          );
          if (response.statusCode == 200) {
            removeRequest(request);
          }
        } catch (e) {
          // Handle error
        }
      }
    }
  }
}
