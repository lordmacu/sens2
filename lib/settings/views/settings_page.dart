import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

class SettingsPage extends StatelessWidget {
  final SettingsController settingsController = Get.put(SettingsController());
  final TextEditingController urlController = TextEditingController();
  final TextEditingController portController = TextEditingController();

  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inicializar los controladores de texto con los valores guardados
    urlController.text = settingsController.serverUrl.value;
    portController.text = settingsController.serverPort.value;

    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: urlController,
              decoration: const InputDecoration(
                labelText: 'Ruta del Servidor',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: portController,
              decoration: const InputDecoration(
                labelText: 'Puerto del Servidor',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                settingsController.saveSettings(
                  urlController.text,
                  portController.text,
                );
                Get.snackbar('Configuración', 'Configuración guardada');
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
