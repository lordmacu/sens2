import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/services/api_client.dart';

class SettingsController extends GetxController {
  final ApiClient apiClient = Get.find<ApiClient>();
  final storage = GetStorage();

  var serverUrl = ''.obs;
  var serverPort = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  void loadSettings() {
    serverUrl.value = storage.read('serverUrl') ?? 'http://localhost';
    serverPort.value = storage.read('serverPort') ?? '3500';
    apiClient.setBaseUrl('${serverUrl.value}:${serverPort.value}/');
  }

  void saveSettings(String url, String port) {
    serverUrl.value = url;
    serverPort.value = port;
    storage.write('serverUrl', url);
    storage.write('serverPort', port);
    apiClient.setBaseUrl('$url:$port/');
  }
}
