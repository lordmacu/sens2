import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/servidor_controller.dart';


class ServidorBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<ServidorController>(() => ServidorController(
    ));
  }
}