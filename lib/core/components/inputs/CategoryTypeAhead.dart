import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CategoryTypeAhead extends StatefulWidget {
  final String categoryName;
  final String text;
  final TextEditingController controller;
  final Function(dynamic) onSuggestionSelectedCallback;
  final List<String>? displayFields; // Lista opcional de campos a mostrar
  final String? suffixText; // Texto adicional que se agrega a cada sugerencia
  final bool returnFullObject; // Controla si se devuelve el objeto completo o solo el texto

  const CategoryTypeAhead({
    super.key,
    required this.categoryName,
    required this.text,
    required this.controller,
    required this.onSuggestionSelectedCallback,
    this.displayFields,
    this.suffixText,
    this.returnFullObject = false, // Por defecto se devuelve solo el texto
  });

  @override
  _CategoryTypeAheadState createState() => _CategoryTypeAheadState();
}

class _CategoryTypeAheadState extends State<CategoryTypeAhead> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged); // Escuchar los cambios en el controlador
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged); // Eliminar el listener al destruir el widget
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {}); // Actualiza el estado cada vez que cambia el texto
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<Map<String, dynamic>>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.text,
          border: const OutlineInputBorder(),
          // Mostrar el botón "X" solo cuando hay texto en el campo
          suffixIcon: widget.controller.text.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              widget.controller.clear(); // Limpiar el campo de texto
            },
          )
              : null,
        ),
      ),
      suggestionsCallback: (pattern) async {
        return await getSuggestions(pattern);
      },
      itemBuilder: (context, Map<String, dynamic> suggestion) {

        // final fields = suggestion['fields'] as Map<String, dynamic>;
        final fields = (suggestion['fields'] as Map<dynamic, dynamic>).map<String, dynamic>((key, value) {
          return MapEntry(key.toString(), value);
        });


        String displayText;
        if (widget.displayFields != null && widget.displayFields!.isNotEmpty) {
          displayText = widget.displayFields!
              .map((field) => fields[field]?.toString() ?? '')
              .where((value) => value.isNotEmpty)
              .join(' - ');
        } else {
          displayText = fields[widget.categoryName]?.toString() ?? '';
        }

        if (widget.suffixText != null && widget.suffixText!.isNotEmpty) {
          displayText = '$displayText ${widget.suffixText}';
        }

        return ListTile(
          title: Text(displayText),
        );
      },
      onSuggestionSelected: (Map<String, dynamic> suggestion) {
        final fields = (suggestion['fields'] as Map<dynamic, dynamic>).map<String, dynamic>((key, value) {
          return MapEntry(key.toString(), value);
        });


        String selectedText;
        if (widget.displayFields != null && widget.displayFields!.isNotEmpty) {
          selectedText = widget.displayFields!
              .map((field) => fields[field]?.toString() ?? '')
              .where((value) => value.isNotEmpty)
              .join(' - ');
        } else {
          selectedText = fields[widget.categoryName]?.toString() ?? '';
        }

        // Agregar el texto adicional al campo de texto seleccionado
        if (widget.suffixText != null && widget.suffixText!.isNotEmpty) {
          selectedText = '$selectedText ${widget.suffixText}';
        }

        // Siempre establecer el texto seleccionado en el controlador
        widget.controller.text = selectedText;

        // Si returnFullObject es true, devolver el objeto completo, de lo contrario solo el texto
        if (widget.returnFullObject) {
          widget.onSuggestionSelectedCallback(suggestion);
        } else {
          widget.onSuggestionSelectedCallback(selectedText);
        }
      },
    );
  }

  Future<List<Map<String, dynamic>>> getSuggestions(String pattern) async {
    // Leer los datos desde GetStorage
    final box = GetStorage();

    // Reading data and converting keys to String explicitly
    List<Map<String, dynamic>> storedItems = box.read<List<dynamic>>(widget.categoryName)?.map((item) {
      return Map<String, dynamic>.from(item as Map<dynamic, dynamic>);
    })?.toList() ?? [];

    print("esta es la data ${storedItems}");

    // Filtrar los resultados según el patrón
    return storedItems.where((item) {
      final fields = (item['fields'] as Map<dynamic, dynamic>).map<String, dynamic>((key, value) {
        return MapEntry(key.toString(), value);
      });
      // Verifica tanto los campos displayFields como el categoryName
      return widget.displayFields != null && widget.displayFields!.isNotEmpty
          ? widget.displayFields!.any((field) => fields[field]?.toString().toLowerCase().contains(pattern.toLowerCase()) ?? false)
          : fields[widget.categoryName]?.toString().toLowerCase().contains(pattern.toLowerCase()) ?? false;
    }).toList();
  }

}
