import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:sens2/core/services/api_client.dart';
import 'request_queue_service.dart';
import 'package:http/http.dart' as http;

class ConnectivityService extends GetxService {
  var isOnline = true.obs;

  @override
  void onInit() {
    super.onInit();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      isOnline.value = result != ConnectivityResult.none;

      if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
        bool hasInternet = await checkInternetAccess();
        isOnline.value = hasInternet;
      } else {
        isOnline.value = result != ConnectivityResult.none;
      }
      if (isOnline.value) {
        _processPendingRequests();
      }
    });
  }

  Future<bool> checkInternetAccess() async {
    final apiClient = Get.put(ApiClient());

    try {
      final response = await http.get(Uri.parse(apiClient.baseUrl)).timeout(Duration(seconds: 5));

      // Si obtienes cualquier respuesta, consideramos que hay conexión
      isOnline.value = true;
      return true; // Conexión a internet exitosa

    } catch (e) {
      // Si ocurre una excepción, no hay conexión
      isOnline.value = false;
      return false; // No se pudo acceder a Internet
    }
  }


  void _processPendingRequests() async {
    await Get.find<RequestQueueService>().processRequests();
  }
}
