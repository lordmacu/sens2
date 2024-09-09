import 'package:flutter/material.dart';

class ButtonGeneral extends StatelessWidget {
  final String text;
  final Color colorValue;
  final double fontSize;
  final VoidCallback onPressed; // Cambié el tipo de Function() a VoidCallback y el nombre a onPressed

  const ButtonGeneral({
    super.key,
    required this.text,
    required this.colorValue,
    this.fontSize = 18,
    required this.onPressed, // Ahora el onPressed es requerido
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: colorValue,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 150),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
           color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
