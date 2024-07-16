import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

class SettingsPage extends StatelessWidget {
  final SettingsController settingsController = Get.put(SettingsController());
  final TextEditingController urlController = TextEditingController();
  final TextEditingController portController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Inicializar los controladores de texto con los valores guardados
    urlController.text = settingsController.serverUrl.value;
    portController.text = settingsController.serverPort.value;

    return Scaffold(
      appBar: AppBar(title: Text('Configuración')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: urlController,
              decoration: InputDecoration(
                labelText: 'Ruta del Servidor',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: portController,
              decoration: InputDecoration(
                labelText: 'Puerto del Servidor',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                settingsController.saveSettings(
                  urlController.text,
                  portController.text,
                );
                Get.snackbar('Configuración', 'Configuración guardada');
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
