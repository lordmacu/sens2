import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:logger/logger.dart';

class TypeAhead extends StatelessWidget {
  final String text;
  final TextEditingController? controller;
  final List<String> suggestions;
  final Function(String)? onSuggestionSelectedCallback;

  // Optional styling parameters with default values
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final OutlineInputBorder? enabledBorder;
  final OutlineInputBorder? focusedBorder;
  final OutlineInputBorder? errorBorder;
  final OutlineInputBorder? focusedErrorBorder;

  const TypeAhead({
    super.key,
    required this.text,
    this.controller,
    this.suggestions = const [],
    this.onSuggestionSelectedCallback,
    this.labelStyle,
    this.textStyle,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Logger logger = Logger(); // Instancia de Logger

    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller,
        decoration: InputDecoration(
          labelText: text,
          labelStyle: labelStyle ?? theme.inputDecorationTheme.labelStyle,
          enabledBorder: enabledBorder ?? theme.inputDecorationTheme.enabledBorder,
          focusedBorder: focusedBorder ?? theme.inputDecorationTheme.focusedBorder,
          errorBorder: errorBorder ?? theme.inputDecorationTheme.errorBorder,
          focusedErrorBorder: focusedErrorBorder ?? theme.inputDecorationTheme.focusedErrorBorder,
          // Add the clear button here
          suffixIcon: controller!.text.isNotEmpty
              ? IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              controller!.clear(); // Clear the input field
            },
          )
              : null,
        ),
        style: textStyle ?? theme.textTheme.bodyLarge,
      ),
      suggestionsCallback: (pattern) {
        return suggestions
            .where((operator) =>
            operator.toLowerCase().contains(pattern.toLowerCase()))
            .toList();
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion),
        );
      },
      onSuggestionSelected: (suggestion) {
        controller?.text = suggestion;
        if (onSuggestionSelectedCallback != null) {
          onSuggestionSelectedCallback!(suggestion);
        }
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      validator: (value) {
        if ((value ?? '').isEmpty) {
          return 'Por favor seleccione un operador';
        }
        return null;
      },
      onSaved: (value) => logger.i('Operador seleccionado: $value'), // Reemplaza print por logger
    );
  }
}
