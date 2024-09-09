import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class PrintTicketExtrusionController extends GetxController {
  final logger = Logger(); // Instancia de Logger

  var orderController = TextEditingController().obs;
  var rollController = TextEditingController().obs;
  var operatorController = TextEditingController().obs;
  var maquinController = TextEditingController().obs;
  var extentController = TextEditingController().obs;
  var thicknessController = TextEditingController().obs;
  var netWeightController = TextEditingController().obs;
  var grossWeightController = TextEditingController().obs;
  var coilController = TextEditingController().obs;
  var colorController = TextEditingController().obs;
  var densityController = TextEditingController().obs;
  var clientController = TextEditingController().obs;

  void send() {
    logger.i('Order: ${orderController.value.text}');
    logger.i('Roll: ${rollController.value.text}');
    logger.i('Operator: ${operatorController.value.text}');
    logger.i('Client: ${clientController.value.text}');
    logger.i('Machine: ${maquinController.value.text}');
    logger.i('Extent: ${extentController.value.text}');
    logger.i('Thickness: ${thicknessController.value.text}');
    logger.i('Color: ${colorController.value.text}');
    logger.i('Density: ${densityController.value.text}');
    logger.i('Client: ${clientController.value.text}');
  }
}
