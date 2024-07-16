import 'package:get/get.dart';
import '../../core/services/mqtt_service.dart';

class MqttSettingsController extends GetxController {
  final MqttService mqttService = Get.find<MqttService>();

  var host = ''.obs;
  var port = 0.obs;
  var clientId = ''.obs;
  var username = ''.obs;
  var password = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  void loadSettings() {
    host.value = mqttService.storage.read('mqttHost') ?? 'test.mosquitto.org';
    port.value = mqttService.storage.read('mqttPort') ?? 1883;
    clientId.value = mqttService.storage.read('mqttClientId') ?? 'mqtt_client';
    username.value = mqttService.storage.read('mqttUsername') ?? '';
    password.value = mqttService.storage.read('mqttPassword') ?? '';
  }

  void saveSettings() {
    mqttService.saveSettings(host.value, port.value, clientId.value, username.value, password.value);
  }
}
