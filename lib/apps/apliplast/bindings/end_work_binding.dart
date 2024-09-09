import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/end_work_controller.dart';




class EndWorkBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<EndWorkController>(() => EndWorkController(
    ));
  }
}