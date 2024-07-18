import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/print_ticket_sealed_controller.dart';


class PrintTicketSealedBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<PrintTicketSealedController>(() => PrintTicketSealedController(
    ));
  }
}