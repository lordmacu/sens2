import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';


class EndWorkController extends GetxController {
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

  // Instancia del Logger
  var logger = Logger();

  void send() {
    logger.d(productionOrderController.value.text);
    logger.d(operatorController.value.text);
    logger.d(maquinController.value.text);
    logger.d(extrusionController.value.text);
    logger.d(clientController.value.text);
    logger.d(subtotalController.value.text);
    logger.d(scrapController.value.text);
    logger.d(tortaController.value.text);
    logger.d(totalProductionController.value.text);
    logger.d(tableController.value.text);
    logger.d(materialController.value.text);
    logger.d(balanceController.value.text);
    logger.d(currentBalanceController.value.text);
  }
}
