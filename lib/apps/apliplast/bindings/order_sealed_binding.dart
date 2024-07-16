import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/oder_sealed_controller.dart';


class OderSealedBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<OderSealedController>(() => OderSealedController(
    ));
  }
}