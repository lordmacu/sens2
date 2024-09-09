import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showEditDialog(BuildContext context) {
  TextEditingController controller = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Peso: 300'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Ingresa"),
        ),
        actions: [
          TextButton(
              style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 5, 16, 77), // Color del texto
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Tamaño del botón
                            ),
             onPressed: () {
                  Get.back(); // Volver a la pantalla anterior
                },
              child: const Text('Cancelar'),
          ),
          TextButton(
            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 5, 16, 77), // Color del texto
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Tamaño del botón
                            ),
            onPressed: () {
              // Save action
              Navigator.of(context).pop();
            },
            child: const Text('Guardar'),
          ),
        ],
      );
    },
  );
}