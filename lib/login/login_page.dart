import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sens2/core/components/buttons/button.dart';
import 'package:sens2/core/components/logo.dart';
import 'package:sens2/core/components/inputs/input_icon.dart';
import 'package:sens2/core/services/api_client.dart';
import 'package:sens2/core/services/auth_service.dart';
import 'package:get_storage/get_storage.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = Get.find<AuthService>();

  final TextEditingController serverUrlController = TextEditingController();
  final storage = GetStorage();
  String selectedProtocol = 'HTTP'; // Default protocol

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      const LogoPrincipal(topValue: 0),
                      const SizedBox(height: 16),
                      _buildWelcomeText(),
                      const SizedBox(height: 32),
                      _buildInputFields(),
                      const SizedBox(height: 32),
                      _buildLoginButton(),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 16,
            child: IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                _showSettingsModal(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeText() {
    return const Column(
      children: [
        Text(
          'Bienvenido',
          style: TextStyle(
            color: Color.fromARGB(255, 25, 38, 83),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildInputFields() {
    return Column(
      children: [
        InputGeneral(
          icon: Icons.email,
          text: 'Correo electrónico',
          controller: usernameController,
        ),
        const SizedBox(height: 19),
        InputGeneral(
          icon: Icons.lock,
          text: 'Contraseña',
          controller: passwordController,
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Obx(() {
      if (authService.isLoggedInProcess.value) {
        return const CircularProgressIndicator();
      } else {
        return ButtonGeneral(
          text: 'Ingresar',
          colorValue: const Color.fromARGB(255, 25, 38, 83),
          fontSize: 12,
          onPressed: () async {
            if (_validateInputs()) {
              try {
                authService.isLoggedInProcess(true);
                await authService.login(
                    usernameController.text, passwordController.text);
              } catch (e) {
                Get.snackbar('Error', 'Failed to login: ${e.toString()}');
              } finally {
                authService.isLoggedInProcess(false);
              }
            }
          },
        );
      }
    });
  }

  bool _validateInputs() {
    if (usernameController.text.isEmpty) {
      Get.snackbar('Error', 'El correo electrónico es requerido.');
      return false;
    }
    if (passwordController.text.isEmpty) {
      Get.snackbar('Error', 'La contraseña es requerida.');
      return false;
    }
    return true;
  }

// Modal para configuración del servidor
  void _showSettingsModal(BuildContext context) {
    // Verifica si el valor del serverUrl ya está guardado en el storage
    String? savedServerUrl = storage.read('serverUrl');

    // Si no hay un valor almacenado, asigna el valor por defecto
    if (savedServerUrl == null) {
      serverUrlController.text = 'https://backend.senscloud.io';
    } else {
      // Si existe un valor almacenado, lo asigna al controlador
      serverUrlController.text = savedServerUrl;
    }

    Get.defaultDialog(
      title: 'Configuración del servidor',
      content: Column(
        children: [

          TextField(
            controller: serverUrlController,
            decoration: const InputDecoration(labelText: 'Server URL'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: (){
              final apiClient = Get.put(ApiClient());

              storage.write('protocol', selectedProtocol);
              storage.write('serverUrl', serverUrlController.text);
              apiClient.setBaseUrl('${serverUrlController.text}:443/');

              Get.snackbar(
                'Configuración guardada',
                'La configuración del servidor ha sido actualizada',
                snackPosition: SnackPosition.BOTTOM,
              );
              Navigator.pop(context);
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }


}
