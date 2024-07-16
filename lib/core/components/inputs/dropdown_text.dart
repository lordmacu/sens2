import 'package:flutter/material.dart';

class DropdownText extends StatelessWidget {
  final List<String> items;

  const DropdownText({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String initialValue = items.isNotEmpty
        ? items.first
        : ''; // Obtener el primer elemento de items

    return Container(
      width: 480,
      height: 40,
      child: DropdownButton<String>(
        isExpanded: true,
        value: initialValue, // Asignar el valor inicial
        onChanged: (String? newValue) {
          // Lógica de cambio de proveedor
        },
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 129, 129, 129),
        ),
        underline: Container(
          height: 1,
          color: Color.fromARGB(167, 88, 97, 121),
        ),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
