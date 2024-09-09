import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/end_work_extrusion_controller.dart';




class EndWorkExtrusionBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<EndWorkExtrusionController>(() => EndWorkExtrusionController(
    ));
  }
}