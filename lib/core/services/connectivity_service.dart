import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'request_queue_service.dart';

class ConnectivityService extends GetxService {
  var isOnline = true.obs;

  @override
  void onInit() {
    super.onInit();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      isOnline.value = result != ConnectivityResult.none;
      if (isOnline.value) {
        _processPendingRequests();
      }
    });
  }

  void _processPendingRequests() async {
    await Get.find<RequestQueueService>().processRequests();
  }
}
