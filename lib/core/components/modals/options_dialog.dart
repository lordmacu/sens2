import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OptionsDialog extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> options;

  OptionsDialog({required this.title, required this.options});

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
              color: Colors.grey[200],  // Fondo gris claro
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Divider(),
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
