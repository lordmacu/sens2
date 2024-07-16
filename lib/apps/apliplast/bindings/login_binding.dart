import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/login_controller.dart';


class LoginBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<LoginController>(() => LoginController(
    ));
  }
}