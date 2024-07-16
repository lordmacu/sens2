import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/semiya_controller.dart';


class SemiyaBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<SemiyaController>(() => SemiyaController(
    ));
  }
}