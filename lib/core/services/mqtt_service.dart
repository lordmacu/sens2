import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

class MqttService extends GetxService {
  late MqttServerClient client;
  final storage = GetStorage();
  var isConnected = false.obs;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    initNotification();
    loadSettings();
  }

  void loadSettings() {
    final host = storage.read('mqttHost') ?? 'test.mosquitto.org';
    final port = storage.read('mqttPort') ?? 1883;
    final clientId = storage.read('mqttClientId') ?? 'mqtt_client';
    final username = storage.read('mqttUsername') ?? '';
    final password = storage.read('mqttPassword') ?? '';
    connect(host, port, clientId, username, password);
  }

  Future<void> connect(String host, int port, String clientId, String username, String password) async {
    client = MqttServerClient(host, clientId);
    client.port = port;
    client.logging(on: true);
    client.keepAlivePeriod = 20;
    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;
    client.onSubscribed = onSubscribed;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .startClean()
        .withWillQos(MqttQos.atLeastOnce).authenticateAs(username, password);
    client.connectionMessage = connMessage;

    try {
      await client.connect(username, password);
    } catch (e) {
      print('Exception: $e');
      disconnect();
    }
  }

  void onConnected() {
    print('Connected');
    isConnected.value = true;
    _showNotification('MQTT', 'Connected');
  }

  void onDisconnected() {
    print('Disconnected');
    isConnected.value = false;
    _showNotification('MQTT', 'Disconnected');
  }

  void onSubscribed(String topic) {
    print('Subscribed to $topic');
  }

  void disconnect() {
    client.disconnect();
  }

  void saveSettings(String host, int port, String clientId, String username, String password) {
    storage.write('mqttHost', host);
    storage.write('mqttPort', port);
    storage.write('mqttClientId', clientId);
    storage.write('mqttUsername', username);
    storage.write('mqttPassword', password);
    connect(host, port, clientId, username, password);
  }

  void initNotification() {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = IOSInitializationSettings();
    const initSettings = InitializationSettings(android: androidSettings, iOS: iosSettings);
    flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  Future<void> _showNotification(String title, String body) async {
    const androidDetails = AndroidNotificationDetails('channelId', 'channelName', importance: Importance.max);
    const iosDetails = IOSNotificationDetails();
    const generalNotificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);
    await flutterLocalNotificationsPlugin.show(0, title, body, generalNotificationDetails);
  }
}
