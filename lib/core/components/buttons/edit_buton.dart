import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  final VoidCallback onPressed;

  const EditButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      color: const Color.fromARGB(255, 204, 204, 204), // Fondo gris claro
      margin: const EdgeInsets.all(4.0), // Margen uniforme
      padding: EdgeInsets.all(0.0),
      child: IconButton(
        icon: Icon(Icons.edit, size: 16),
        padding: EdgeInsets.all(2.0),
        onPressed: onPressed,
        color: Colors.grey.shade700, // Icono gris más oscuro
      ),
    );
  }
}