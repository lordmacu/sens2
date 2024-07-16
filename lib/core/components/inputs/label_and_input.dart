import 'package:flutter/material.dart';

class LabelAndInput extends StatelessWidget {
  final String label;
  final String placeholder;
  final TextStyle labelStyle; // Estilo para el texto del label

  const LabelAndInput({
    Key? key,
    required this.label,
    required this.placeholder,
    this.labelStyle = const TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 11, 19, 68),
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100, 
          child: Text(
            label,
            style: labelStyle,
          ),
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: placeholder,
            ),
          ),
        ),
      ],
    );
  }
}