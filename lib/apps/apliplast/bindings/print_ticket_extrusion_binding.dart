import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/print_ticket_extrusion_controller.dart';


class PrintTicketExtrusionBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<PrintTicketExtrusionController>(() => PrintTicketExtrusionController(
    ));
  }
}