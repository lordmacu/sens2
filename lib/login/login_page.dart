import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sens2/core/components/buttons/button.dart';
import 'package:sens2/core/components/icons/logo.dart';
import 'package:sens2/core/components/inputs/input_icon.dart'; // Asegúrate de importar InputIcon si no lo has hecho
import 'package:sens2/apps/apliplast/controllers/login_controller.dart';
import 'package:sens2/core/components/inputs/input_text.dart';
import 'package:sens2/core/services/auth_service.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text(
                'Bienvenido',
                style: TextStyle(
                  color: Color.fromARGB(255, 25, 38, 83),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Logueate en tu cuenta',
                style: TextStyle(
                  color: Color.fromARGB(255, 25, 38, 83),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              InputGeneral(icon: Icons.email, text: 'Correo electrónico'), // Utiliza InputIcon para el correo electrónico
              SizedBox(height: 19),
              InputGeneral(icon: Icons.lock, text: 'Contraseña'), // Utiliza InputIcon para la contraseña
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Color.fromARGB(255, 25, 38, 83),
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(
                        color: Color.fromARGB(255, 25, 38, 83),
                        fontSize: 12,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '¿Necesitas ayuda?',
                      style: TextStyle(
                        color: Color.fromARGB(255, 25, 38, 83),
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
             Obx(() {
                final authService = Get.find<AuthService>();
                if (authService == null || authService.isLoggedIn.value) {
                  return CircularProgressIndicator();
                } else {
                  return ButtonGeneral(
                    text: 'Ingresar',
                    colorValue: Color.fromARGB(255, 25, 38, 83),
                    fontSize: 14,
                   // onPressed: () async {
                      //try {
                      //  await authService.login(
                      //      usernameController.text, passwordController.text);
                     // } catch (e) {
                     //   Get.snackbar('Error', 'Failed to login');
                     // }
                   // },
                  );
                }
              }),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
