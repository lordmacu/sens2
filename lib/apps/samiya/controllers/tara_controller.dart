import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TableController extends GetxController {
  var data = <Map<String, dynamic>>[].obs;  // Almacena los datos procesados
  var filteredData = <Map<String, dynamic>>[].obs;  // Almacena los datos filtrados
  var headers = <String, String>{}.obs;  // Almacena los headers y su mapeo a los campos
  var title = "".obs;
  var editableFields = <String, Map<String, String>>{}.obs; // Almacena los campos editables y su tipo

  List<Map<String, dynamic>> _originalData = [];  // Almacena los datos originales para poder filtrar

  // Función para cargar ítems basados en la categoría y los headers definidos
  Future<void> loadItems(
      String category,
      Map<String, String> headersMapping,
      String title,
      Map<String, Map<String, String>> editableFieldsMapping) async {
    final storage = GetStorage();
    editableFields.value = editableFieldsMapping;

    headers.value = headersMapping;
    this.title.value = title;

    // Leer los ítems desde el almacenamiento
    var items = await storage.read(category) as List<dynamic>;

    // Procesar los datos para incluir solo los campos definidos en headers
    _originalData = items.map((item) {
      Map<String, dynamic> processedItem = {};

      headers.forEach((header, field) {
        processedItem[header] = item['fields'][field];
      });

      return processedItem;
    }).toList();

    data.value = _originalData;
    filteredData.value = _originalData;

    print("Processed items: $data");
  }

   void filterTable(String query) {
    if (query.isEmpty) {
      filteredData.value = _originalData;
    } else {
      filteredData.value = _originalData.where((item) {
        return item.values.any((value) =>
            value.toString().toLowerCase().contains(query.toLowerCase()));
      }).toList();
    }
  }
}
