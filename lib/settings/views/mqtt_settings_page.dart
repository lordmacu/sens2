import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/mqtt_settings_controller.dart';

class MqttSettingsPage extends StatelessWidget {
  final MqttSettingsController settingsController = Get.put(MqttSettingsController());

  final TextEditingController hostController = TextEditingController();
  final TextEditingController portController = TextEditingController();
  final TextEditingController clientIdController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  MqttSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    hostController.text = settingsController.host.value;
    portController.text = settingsController.port.value.toString();
    clientIdController.text = settingsController.clientId.value;
    usernameController.text = settingsController.username.value;
    passwordController.text = settingsController.password.value;

    return Scaffold(
      appBar: AppBar(title: const Text('MQTT Configuration')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: hostController,
              decoration: const InputDecoration(labelText: 'MQTT Host'),
            ),
            TextField(
              controller: portController,
              decoration: const InputDecoration(labelText: 'MQTT Port'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: clientIdController,
              decoration: const InputDecoration(labelText: 'Client ID'),
            ),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                settingsController.host.value = hostController.text;
                settingsController.port.value = int.parse(portController.text);
                settingsController.clientId.value = clientIdController.text;
                settingsController.username.value = usernameController.text;
                settingsController.password.value = passwordController.text;
                settingsController.saveSettings();
                Get.snackbar('Configuration', 'MQTT settings saved');
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
