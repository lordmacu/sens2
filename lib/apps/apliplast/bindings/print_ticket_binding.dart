import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/print_ticket_controller.dart';


class PrintTicketBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<PrintTicketController>(() => PrintTicketController(
    ));
  }
}