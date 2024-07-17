import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OptionsDialog extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> options;
  final dynamic optionalValue; // Valor opcional que puede ser texto o número

  OptionsDialog({
    required this.title,
    required this.options,
    this.optionalValue, // Valor opcional
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.only(top: 45.0, left: 10.0, right: 10.0, bottom: 10.0), // Espacio superior para el botón de cierre
            decoration: BoxDecoration(
              color: Color.fromARGB(31, 128, 128, 128),  // Fondo gris claro
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                if (optionalValue != null) // Mostrar el valor opcional si está presente
                  SizedBox(height: 8),
                if (optionalValue is int) // Mostrar el valor como número si es un int
                  Text(
                    '$optionalValue kg',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                if (optionalValue is String) // Mostrar el valor como texto si es un String
                  Text(
                    'Texto opcional: $optionalValue',
                    style: TextStyle(fontSize: 16),
                  ),
                
                ListBody(
                  children: options.map((option) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 25, 38, 83),
                          padding: EdgeInsets.all(15.0),
                        ),
                        child: Text(
                          option['text'],
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: option['onPressed'],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Positioned(
            right: 5,
            top: 1,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}
