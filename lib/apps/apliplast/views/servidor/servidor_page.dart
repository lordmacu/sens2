import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sens2/core/components/buttons/button_general.dart';
import 'package:sens2/core/services/api_client.dart';

class ServidorPage extends StatefulWidget {
  const ServidorPage({super.key});

  @override
  _ServidorPageState createState() => _ServidorPageState();
}

class _ServidorPageState extends State<ServidorPage> {
  final GetStorage storage = GetStorage();
  late String selectedProtocol;
  late TextEditingController serverUrlController;

  @override
  void initState() {
    super.initState();
     selectedProtocol = storage.read('protocol') ?? 'https';
    serverUrlController = TextEditingController(
      text: storage.read('serverUrl') ?? 'backend.senscloud.io',
    );
  }

  void _saveServerSettings() {
    final apiClient = Get.find<ApiClient>();

    storage.write('protocol', selectedProtocol);
    storage.write('serverUrl', serverUrlController.text);
    apiClient.setBaseUrl('${serverUrlController.text}:443/');

    Get.snackbar(
      'Configuración guardada',
      'La configuración del servidor ha sido actualizada',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 38, 83),
        title: const Text(
          'Servidor',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Volver a la pantalla anterior
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(40, 79, 92, 150),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const SizedBox(height: 16),
                    TextField(

                      controller: serverUrlController,
                      decoration: const InputDecoration(

                        hintText: 'Ruta del Servidor',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      enabled: false,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ButtonGeneral(
                text: 'Guardar',
                colorValue: const Color.fromARGB(255, 25, 38, 83),
                fontSize: 14,
                onPressed: _saveServerSettings,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
