
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class PrintTicketController extends GetxController {
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



  void send(){
    print(orderController.value.text);
    print(orderController.value.text);
    print(rollController.value.text);
    print(operatorController.value.text);
    print(clientController.value.text);
    print(maquinController.value.text);
    print(extentController.value.text);
    print(thicknessController.value.text);
    print(colorController.value.text);
    print(densityController.value.text);
    print(clientController.value.text);

  }
}



