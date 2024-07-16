import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/imprimir_controller.dart';


class ImprimirBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<ImprimirController>(() => ImprimirController(
    ));
  }
}