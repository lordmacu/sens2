import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sens2/core/components/buttons/button.dart';
import 'package:sens2/core/components/logo.dart';
import 'package:sens2/core/components/inputs/input_icon.dart';
import 'package:sens2/core/services/auth_service.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = Get.find<AuthService>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height, // Ajusta la altura del contenedor al tamaño de la pantalla
          child: Center( // Centra el contenido vertical y horizontalmente
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
      if (authService.isLoggedIn.value) {
        return const CircularProgressIndicator();
      } else {
        return ButtonGeneral(
          text: 'Ingresar',
          colorValue: const Color.fromARGB(255, 25, 38, 83),
          fontSize: 12,
          onPressed: () async {
            if (_validateInputs()) {
              try {
                authService.isLoggedIn(true);
                await authService.login(
                    usernameController.text, passwordController.text);
              } catch (e) {
                Get.snackbar('Error', 'Failed to login: ${e.toString()}');
              } finally {
                authService.isLoggedIn(false);
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
}
