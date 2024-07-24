import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showEditDialog(BuildContext context) {
  TextEditingController _controller = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Peso: 300'),
        content: TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: "Ingresa"),
        ),
        actions: [
          TextButton(
              child: Text('Cancelar'),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 5, 16, 77), // Fondo del botón
                              onPrimary: Colors.white, // Color del texto
                              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Tamaño del botón
                            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Guardar'),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 5, 16, 77), // Fondo del botón
                              onPrimary: Colors.white, // Color del texto
                              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Tamaño del botón
                            ),
            onPressed: () {
              // Save action
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}