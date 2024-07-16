import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/register_controller.dart';


class RegisterBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<RegisterController>(() => RegisterController(
    ));
  }
}