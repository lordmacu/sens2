
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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

  void send() {
    print(productionOrderController.value.text);
    print(operatorController.value.text);
    print(maquinController.value.text);
    print(extrusionController.value.text);
    print(clientController.value.text);
    print(subtotalController.value.text);
    print(scrapController.value.text);
    print(tortaController.value.text);
    print(totalProductionController.value.text);
    print(tableController.value.text);
    print(materialController.value.text);
    print(balanceController.value.text);
    print(currentBalanceController.value.text);
  }
}


