

import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/extrusion_controller.dart';


class ExtrusionReportBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExtrusionController>(() => ExtrusionController(
    ));
  }
}