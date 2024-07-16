import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/order_production_controller.dart';


class OrderProductionBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<OrderProductionController>(() => OrderProductionController(
    ));
  }
}