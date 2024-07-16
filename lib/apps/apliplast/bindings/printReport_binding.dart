import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/print_report_controller.dart';


class PrintReportBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<PrintReportController>(() => PrintReportController(
    ));
  }
}