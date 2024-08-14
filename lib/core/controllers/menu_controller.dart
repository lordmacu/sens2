import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MenuDrawerController extends GetxController {
  var menuItems = <Map<String, String>>[].obs;


  Future<void> loadMenuItems(Map<String, String> categoryMenuMapping) async {
    final storage = GetStorage();
    var categories = storage.read<List<dynamic>>('categories');

    if (categories != null) {
      menuItems.value = categories.map((category) {
        return {
          'key': category as String,
          'value': categoryMenuMapping[category] ?? category as String,
        };
      }).toList();
    } else {
      print("No se encontraron categorías en el almacenamiento.");
    }
  }

}
