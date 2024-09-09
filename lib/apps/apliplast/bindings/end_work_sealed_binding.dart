import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/end_work_sealed_controller.dart';




class EndWorkSealedBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<EndWorkSealedController>(() => EndWorkSealedController(
    ));
  }
}