import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get_storage/get_storage.dart';

class CategoryTypeAhead extends StatelessWidget {
  final String categoryName;
  final String text;
  final String searchKey;
  final TextEditingController controller;
  final Function(String)? onSuggestionSelectedCallback;

  // Optional styling parameters with default values
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final OutlineInputBorder? enabledBorder;
  final OutlineInputBorder? focusedBorder;
  final OutlineInputBorder? errorBorder;
  final OutlineInputBorder? focusedErrorBorder;

  const CategoryTypeAhead({
    super.key,
    required this.categoryName,
    required this.text,
    required this.searchKey,
    required this.controller,
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
    final box = GetStorage();

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
        ),
        style: textStyle ?? theme.textTheme.bodyLarge,
      ),
      suggestionsCallback: (pattern) {
        final rawSuggestions = box.read(categoryName);

        print("estas son las sugerencias ${rawSuggestions} ${categoryName}");
        if (rawSuggestions is List) {
          return rawSuggestions
              .where((item) {
            final fields = item['fields'];
            if (fields is Map) {
              final keyValue = fields[searchKey]?.toString().toLowerCase() ?? '';
              return keyValue.contains(pattern.toLowerCase());
            }
            return false;
          })
              .map((item) => item['fields'][searchKey].toString())
              .toList();
        } else {
          return []; // Retorna una lista vacía si no es una lista válida
        }
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion),
        );
      },
      onSuggestionSelected: (suggestion) {
        controller.text = suggestion;
        if (onSuggestionSelectedCallback != null) {
          onSuggestionSelectedCallback!(suggestion);
        }
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      validator: (value) {
        if ((value ?? '').isEmpty) {
          return 'Por favor seleccione una opción';
        }
        return null;
      },
    );
  }
}
