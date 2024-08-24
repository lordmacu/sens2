import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  final VoidCallback onPressed;

  const EditButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      color: const Color.fromARGB(255, 204, 204, 204), // Fondo gris claro
      margin: const EdgeInsets.all(4.0), // Margen uniforme
      padding: const EdgeInsets.all(0.0),
      child: IconButton(
        icon: const Icon(Icons.edit, size: 16),
        padding: const EdgeInsets.all(2.0),
        onPressed: onPressed,
        color: Colors.grey.shade700, // Icono gris más oscuro
      ),
    );
  }
}