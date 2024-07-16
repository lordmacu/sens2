import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/register_controller.dart';
import 'package:sens2/core/components/icons/logo.dart';

class RegisterPage extends StatelessWidget {
  static String id = 'login_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Logo
          Logo(topValue: 50),

          // Main login
          MainRegister(),
        ],
      ),
    );
  }
}

class MainRegister extends StatelessWidget {
  const MainRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Text(
              'Registrate',
              style: TextStyle(
                color: Color.fromARGB(255, 25, 38, 83),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Registra una cuenta',
              style: TextStyle(
                color: Color.fromARGB(255, 25, 38, 83),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Input email
            InputGeneral(icon: Icons.lock, text: 'Contraseña'),

            const SizedBox(height: 19),

            // Input password
            InputGeneral(icon: Icons.lock, text: 'Contraseña'),

            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Color.fromARGB(255, 25, 38, 83),
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text(
                    '¿Olvidaste tu correo?',
                    style: TextStyle(
                      color: Color.fromARGB(255, 25, 38, 83),
                      fontSize: 13,
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
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 25, 38, 83),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 150),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Text(
                'Ingresar',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class InputGeneral extends StatelessWidget {
  final String text;
  final IconData icon;

  const InputGeneral({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        width: 370,
        child: TextField(
          decoration: InputDecoration(
            hintText: text,
            filled: true,
            hintStyle: TextStyle(color: Color.fromARGB(255, 25, 38, 83)),
            fillColor: Color.fromARGB(73, 210, 209, 231).withOpacity(0.7),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            ),
            prefixIcon: Icon(icon, color: Color.fromARGB(255, 49, 48, 122)),
          ),
          obscureText: true,
          keyboardType: TextInputType.emailAddress,
        ),
      ),
    );
  }
}
