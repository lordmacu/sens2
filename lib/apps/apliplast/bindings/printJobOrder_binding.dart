import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/print_order_controller.dart';


class PrintJobOrderBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<PrintJobOrderController>(() => PrintJobOrderController(
    ));
  }
}