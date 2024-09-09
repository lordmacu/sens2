import 'package:get/get.dart';
import 'package:sens2/core/controllers/table_controller.dart';

class TableBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TableController>(() => TableController());
  }
}
