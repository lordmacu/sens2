import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sens2/apps/samiya/controllers/tara_controller.dart';

class EditableFieldsDialogContent extends StatelessWidget {
  final Map<String, Map<String, dynamic>> editableFieldsMapping;
  final Map<String, dynamic> initialValues;  // Valores iniciales para prellenar

  // Obtén el controlador de GetX
  final TableController tableController = Get.find<TableController>();

  EditableFieldsDialogContent({
    required this.editableFieldsMapping,
    required this.initialValues,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...editableFieldsMapping.entries.map((entry) {
          final fieldConfig = entry.value;
          final fieldName = fieldConfig['name'];

          final currentValue = initialValues[fieldName]?.toString();

          print("current id ${initialValues}");
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: fieldConfig['type'] == 'textfield'
                ? TextField(
              decoration: InputDecoration(
                hintText: fieldConfig['name'],
              ),
              controller: TextEditingController(text: currentValue),
              onChanged: (value) {
                final fieldName = fieldConfig['name'];
                             tableController.setFieldValue(fieldConfig["value"], value, fieldName);
              },
            )
                : DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: fieldConfig['name'],
              ),
              value: currentValue,
              items: tableController.getDropdownItems(entry.key),
              onChanged: (value) {
                if (value != null) {
                  final fieldName = fieldConfig['name'];
                  print("Nombre del campo: $fieldName");

                  print("aquii iel entry ${entry}");
                 tableController.setFieldValue(entry.key, value, fieldName);
                }
              },
            ),
          );
        }).toList(),
      ],
    );
  }
}
