import 'package:get/get.dart';




class CatchWeightBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<CatchWeightBinding>(() => CatchWeightBinding(
    ));
  }
}