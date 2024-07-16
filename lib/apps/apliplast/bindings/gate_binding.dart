import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/gate_controller.dart';


class GateBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<GateController>(() => GateController(
    ));
  }
}