import 'package:get/get.dart';
import 'package:sens2/apps/samiya/controllers/tara_controller.dart';

class TableBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TableController>(() => TableController());
  }
}
