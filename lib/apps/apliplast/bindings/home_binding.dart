import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/home_controller.dart';


class HomeBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<HomeController>(() => HomeController(
     ));
  }
}