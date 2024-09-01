import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class CatchWeightController extends GetxController {
  final logger = Logger(); // Instancia de Logger

  // Controladores para los campos de texto
  var palletController = TextEditingController().obs;
  var supplierController = TextEditingController().obs;
  var materialController = TextEditingController().obs;
  var lotController = TextEditingController().obs; // Ejemplo para 'Lote'

  // Otros controladores si son necesarios
  var operatorController = TextEditingController().obs;
  var netWeightController = TextEditingController().obs;
  var grossWeightController = TextEditingController().obs;

  void send() {
    logger.i('Pallet: ${palletController.value.text}');
    logger.i('Supplier: ${supplierController.value.text}');
    logger.i('Material: ${materialController.value.text}');
    logger.i('Lot: ${lotController.value.text}');
    logger.i('Operator: ${operatorController.value.text}');
    logger.i('Net Weight: ${netWeightController.value.text}');
    logger.i('Gross Weight: ${grossWeightController.value.text}');
  }
}
