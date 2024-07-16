import 'dart:isolate';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:get_storage/get_storage.dart';

class FirstTaskHandler extends TaskHandler {
  SendPort? _sendPort;
  late MqttServerClient client;

  @override
  void onStart(DateTime timestamp, SendPort? sendPort) async {
    _sendPort = sendPort;

    // Obtener credenciales de GetStorage
    final storage = GetStorage();
    final broker = storage.read('mqttBroker') ?? 'test.mosquitto.org';
    final port = storage.read('mqttPort') ?? 1883;
    final clientId = storage.read('mqttClientId') ?? 'flutter_mqtt_client';
    final username = storage.read('mqttUsername');
    final password = storage.read('mqttPassword');

    // Inicializar el cliente MQTT
    client = MqttServerClient(broker, clientId);
    client.port = port;
    client.logging(on: true);
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
      client.disconnect();
    }
  }

  void onConnected() {
    print('Connected');
    client.subscribe('test/topic', MqttQos.atMostOnce);
  }

  void onDisconnected() {
    print('Disconnected');
  }

  void onSubscribed(String topic) {
    print('Subscribed to $topic');
  }

  @override
  void onRepeatEvent(DateTime timestamp, SendPort? sendPort) async {
    sendPort?.send(timestamp.toIso8601String());
  }

  @override
  void onDestroy(DateTime timestamp, SendPort? sendPort) async {
    client.disconnect();
    print('onDestroy');
  }

  @override
  void onNotificationButtonPressed(String id) {
    print('onNotificationButtonPressed >> $id');
  }

  @override
  void onNotificationPressed() {
    FlutterForegroundTask.launchApp("/resume-route");
    _sendPort?.send('onNotificationPressed');
  }
}
