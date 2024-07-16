import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/pageview_controller.dart';


class PageViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PageviewController>(() => PageviewController(
    ));
  }
}