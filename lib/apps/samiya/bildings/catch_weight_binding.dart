import 'package:get/get.dart';
import 'package:sens2/apps/samiya/controllers/catch_weight_controller.dart';




class CatchWeightBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<CatchWeightBinding>(() => CatchWeightBinding(
    ));
  }
}