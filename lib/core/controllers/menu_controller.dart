import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

class MenuDrawerController extends GetxController {
  var menuItems = <Map<String, String>>[].obs;

  final Logger logger = Logger(); // Instancia del logger

  Future<void> loadMenuItems(Map<String, String> categoryMenuMapping) async {
    final storage = GetStorage();
    var categories = storage.read<List<dynamic>>('categories');

    if (categories != null) {
      menuItems.value = categories.map((category) {
        return {
          'key': category as String,
          'value': categoryMenuMapping[category] ?? category,
        };
      }).toList();
    } else {
      logger.w("No se encontraron categorías en el almacenamiento."); // Reemplazo de print
    }
  }
}
