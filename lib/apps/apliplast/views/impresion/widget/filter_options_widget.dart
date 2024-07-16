import 'package:flutter/material.dart';

class FilterOptionsWidget extends StatefulWidget {
  final List<String> options;
  final TextEditingController? controller;
  final String title; // Añadido aquí

  const FilterOptionsWidget({
    Key? key,
    required this.options,
    this.controller,
    this.title = 'Options', // Valor por defecto
  }) : super(key: key);

  @override
  _FilterOptionsWidgetState createState() => _FilterOptionsWidgetState();
}

class _FilterOptionsWidgetState extends State<FilterOptionsWidget> {
  final List<String> selectedOptions = [];

  void _toggleOption(String option) {
    setState(() {
      if (selectedOptions.contains(option)) {
        selectedOptions.remove(option);
      } else {
        selectedOptions.add(option);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text(
          widget.title, // Cambiado aquí
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          children: widget.options.map((option) {
            final isSelected = selectedOptions.contains(option);
            return FilterChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (bool selected) {
                _toggleOption(option);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
