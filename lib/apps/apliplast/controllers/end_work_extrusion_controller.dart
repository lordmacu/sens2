import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class EndWorkExtrusionController extends GetxController {
  final logger = Logger(); // Instancia de Logger

  var productionOrderController = TextEditingController().obs;
  var operatorController = TextEditingController().obs;
  var maquinController = TextEditingController().obs;
  var extrusionController = TextEditingController().obs;
  var clientController = TextEditingController().obs;
  var subtotalController = TextEditingController().obs;
  var scrapController = TextEditingController().obs;
  var orderController = TextEditingController().obs;
  var tortaController = TextEditingController().obs;
  var totalProductionController = TextEditingController().obs;
  var tableController = TextEditingController().obs;
  var materialController = TextEditingController().obs;
  var balanceController = TextEditingController().obs;
  var currentBalanceController = TextEditingController().obs;

  void send() {
    logger.i('Production Order: ${productionOrderController.value.text}');
    logger.i('Operator: ${operatorController.value.text}');
    logger.i('Machine: ${maquinController.value.text}');
    logger.i('Extrusion: ${extrusionController.value.text}');
    logger.i('Client: ${clientController.value.text}');
    logger.i('Subtotal: ${subtotalController.value.text}');
    logger.i('Scrap: ${scrapController.value.text}');
    logger.i('Torta: ${tortaController.value.text}');
    logger.i('Total Production: ${totalProductionController.value.text}');
    logger.i('Table: ${tableController.value.text}');
    logger.i('Material: ${materialController.value.text}');
    logger.i('Balance: ${balanceController.value.text}');
    logger.i('Current Balance: ${currentBalanceController.value.text}');
  }
}
