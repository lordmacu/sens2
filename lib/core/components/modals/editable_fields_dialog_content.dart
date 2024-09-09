import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sens2/core/controllers/table_controller.dart';

class EditableFieldsDialogContent extends StatelessWidget {
  final Map<String, Map<String, dynamic>> editableFieldsMapping;
  final Map<String, dynamic> initialValues;  // Valores iniciales para prellenar

  // Obtén el controlador de GetX
  final TableController tableController = Get.find<TableController>();
  final Logger logger = Logger(); // Instancia del logger

  EditableFieldsDialogContent({super.key, 
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

          logger.i("current id $initialValues"); // Reemplazo de print
          
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
                        logger.i("Nombre del campo: $fieldName"); // Reemplazo de print

                        logger.i("aquii iel entry $entry"); // Reemplazo de print
                        tableController.setFieldValue(entry.key, value, fieldName);
                      }
                    },
                  ),
          );
        }),
      ],
    );
  }
}