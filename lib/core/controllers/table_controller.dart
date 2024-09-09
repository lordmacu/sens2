import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:sens2/core/services/request_queue_service.dart';
import 'package:uuid/uuid.dart';
import 'package:logger/logger.dart';

class TableController extends GetxController {
  final Logger logger = Logger();

  var data = <Map<String, dynamic>>[].obs;
  var filteredData = <Map<String, dynamic>>[].obs;
  var headers = <String, String>{}.obs;
  var title = "".obs;
  var editableFields = <String, Map<String, dynamic>>{}.obs;
  var category = "".obs;

  List<Map<String, dynamic>> _originalData = [];
  final List<Map<String, dynamic>> _currentEditableValues = [];
  final RequestQueueService requestQueue = Get.put(RequestQueueService());

  var sortedColumn = ''.obs;
  var isAscending = true.obs;

  Future<void> loadItems(
      String category,
      Map<String, String> headersMapping,
      String title,
      Map<String, Map<String, dynamic>> editableFieldsMapping) async {
    final storage = GetStorage();
    editableFields.value = editableFieldsMapping;

    headers.value = headersMapping;
    this.title.value = title;

    logger.i("Cargando categoría: $category");
    var items = await storage.read(category) as List<dynamic>;
    this.category.value = category;

    _originalData = items.map((item) {
      Map<String, dynamic> processedItem = {};

      // Guardar el id del item
      processedItem = item;

      // Procesar los demás campos
      headers.forEach((header, field) {
        processedItem[header] = item['fields'][field];
      });

      return processedItem;
    }).toList();

    data.value = _originalData;
    filteredData.value = _originalData;

    logger.i("Items procesados: $filteredData");
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

  void setFieldValue(String key, dynamic value, String fieldName) {
    int index = _currentEditableValues.indexWhere((item) => item['key'] == key);

    if (index != -1) {
      _currentEditableValues[index] = {
        "key": key,
        "value": value,
        "name": fieldName
      };
    } else {
      _currentEditableValues
          .add({"key": key, "value": value, "name": fieldName});
    }
  }

  List<DropdownMenuItem<String>> getDropdownItems(String key) {
    final storage = GetStorage();

    final storedTable = storage.read(key) as List<dynamic>?;

    List<String> items = [];

    if (storedTable != null && storedTable.isNotEmpty) {
      logger.i("Contenido del almacenamiento: $storedTable");

      items = storedTable
          .map((item) => item['fields']['key'] as String?)
          .where((value) => value != null)
          .cast<String>()
          .toList();
    } else {
      items = editableFields[key]?['values']?.cast<String>() ?? [];
    }

    return items.map((item) {
      return DropdownMenuItem<String>(
        value: item,
        child: Text(item),
      );
    }).toList();
  }

  setItemAfterCreate(index, item){
    _originalData[index] = Map<String, dynamic>.from(item);

    filteredData.value = _originalData;
    data.value = _originalData;

    data.refresh();
    filteredData.refresh();
  }

  void saveEditedItem(Map<String, dynamic> editedItem) async {
    final Map<String, dynamic> updatedFields = Map.from(editedItem['fields']);

    for (var element in _currentEditableValues) {
      var elementKey = element["key"];
      var valueEdited = element["value"];

      editedItem[element["name"]] = valueEdited;

      if (updatedFields.containsKey(elementKey)) {
        updatedFields[elementKey] = valueEdited;
        logger.i("Campo '$elementKey' actualizado a: $valueEdited");
      }
    }

    editedItem['fields'] = updatedFields;

    int index =
        _originalData.indexWhere((item) => item['id'] == editedItem['id']);

    if (index != -1) {
      _originalData[index] = Map<String, dynamic>.from(editedItem);
      data[index] = Map<String, dynamic>.from(editedItem);
      filteredData[index] = Map<String, dynamic>.from(editedItem);

      data.refresh();
      filteredData.refresh();
    }

    final storage = GetStorage();
    await storage.write(category.value, _originalData);
    enqueueRequest('PUT', 'api/paramsOrganizations/edit/${editedItem['id']}',updatedFields,editedItem['id'] );
  }

  void addNewItem() async {
    var uuid = const Uuid();
    String newId = uuid.v4();

    final Map<String, dynamic> newItem = {
      'id': newId,
      'fields': {},
    };

    final Map<String, dynamic> newItemAdd = {
      'id': newId,
      'fields': {},
    };


    final Map<String, dynamic> fields = {};

    for (var element in _currentEditableValues) {
      var elementKey = element["key"];
      var value = element["value"];
      var elementName = element["name"];

      newItem['fields'][elementKey] = value;
      newItemAdd['fields'][elementKey] = value;

      newItem[elementName] = value;
      fields[elementKey] = value;
    }

    logger.i("Adding item with fields: $fields");

    List<Map<String, dynamic>> clonedData = _originalData.map((item) => Map<String, dynamic>.from(item)).toList();

    clonedData.insert(0, Map<String, dynamic>.from(newItemAdd));

    _originalData.insert(0, Map<String, dynamic>.from(newItem));

    filteredData.value = _originalData;
    data.value = _originalData;

    data.refresh();
    filteredData.refresh();

    final storage = GetStorage();
    await storage.write(category.value, clonedData);
    enqueueRequest('POST', 'api/paramsOrganizations', fields, newId);
  }



  void deleteItem(String itemId) async {
    int index = _originalData.indexWhere((item) => item['id'] == itemId);

    if (index != -1) {
      _originalData.removeAt(index);
      data.value = _originalData;
      filteredData.value = _originalData;

      data.refresh();
      filteredData.refresh();

      final storage = GetStorage();
      await storage.write(category.value, _originalData);

      logger.i("Item con id '$itemId' eliminado.");
      enqueueRequest('DELETE', 'api/paramsOrganizations/delete/${itemId}', {}, null);
    } else {
      logger.w("No se encontró un item con id '$itemId' en '_originalData'.");
    }
  }

  void sortData(String columnName) {
    if (sortedColumn.value == columnName) {
      isAscending.value = !isAscending.value; // Toggle the sort order
    } else {
      sortedColumn.value = columnName;
      isAscending.value = true;
    }

    filteredData.sort((a, b) {
      final aValue = a[columnName];
      final bValue = b[columnName];

      if (aValue == null || bValue == null) {
        return 0;
      }

      if (isAscending.value) {
        return aValue.compareTo(bValue);
      } else {
        return bValue.compareTo(aValue);
      }
    });

    data.refresh();
    filteredData.refresh();
  }

  void enqueueRequest(String method, String endpoint, Map<String, dynamic> item, String? id) {
    var request;
    if (item != null) {
      // Construct the body of the request
      final Map<String, dynamic> body = {
        "organization": "samiya",
        "name": category.value,
        "fields": item
      };

      // Add 'id' if it is provided
      if (id != null) {
        body['id'] = id;
      }

      // Create the request with the body
      request = {
        'method': method,
        'endpoint': endpoint,
        'module': "table",
        'body': body
      };
    } else {
      // If no item, create the request without body
      request = {
        'method': method,
        'module': "table",
        'endpoint': endpoint
      };
    }

    requestQueue.addRequest(request);
  }
}