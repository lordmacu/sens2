import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:sens2/core/services/api_client.dart';
import 'package:sens2/core/services/connectivity_service.dart';
import 'package:sens2/core/services/request_queue_service.dart';
import 'package:uuid/uuid.dart';

class LoteController extends GetxController {
  var lotes = [].obs;

  var loteFilterController = TextEditingController().obs;
  var fechaFilterController = TextEditingController().obs;

  var editLoteController = TextEditingController().obs;
  var editPesoController = TextEditingController().obs;
  var editProveedorController = TextEditingController().obs;
  var editSupplierController = TextEditingController().obs;
  var editProductController = TextEditingController().obs;
  var editUnitsController = TextEditingController().obs;
  var editDateController = TextEditingController().obs;

  final RequestQueueService requestQueue = Get.put(RequestQueueService());
  var customToken = "877f21428132a6c9f3d55bb8163fcb24";
  final Logger logger = Logger();

  @override
  void onInit() {
    super.onInit();
  }

  // Función para agregar un nuevo lote
  void sendData(String batch, String peso, String supplier, String product, String date) {
    final fields = {
      "batch": int.parse(batch),
      "weight": {"value": double.tryParse(peso) ?? 0, "units": "kg"},
      "supplier": supplier,
      "date": date,
      "product": product,
      "gateway_id": "SAM01001"
    };

    var uuid = const Uuid();
    String newId = uuid.v4();

    final payloadToAdd = {
      "id": newId, // Asumiendo que loteId es el identificador del lote actual
      "supplier": supplier,
      "batch": int.parse(batch),
      "date": date,
      "product": product,
      "weight": double.tryParse(peso) ?? 0,
      "weight_units": "kg"
    };

    enqueueRequest('POST', 'api/scale', fields);
    Get.snackbar('Éxito', 'Lote agregado correctamente',
        snackPosition: SnackPosition.BOTTOM);
    resetFields();

    lotes.add(payloadToAdd);
    lotes.refresh();
  }

  void resetFields() {
    editLoteController.value.clear();
    editPesoController.value.clear();
    editSupplierController.value.clear();
    editProductController.value.clear();
    editUnitsController.value.clear();
    editDateController.value.clear();
  }

  Future<void> udpate(loteId) async {
    final payload = {
      "_id": loteId, // Asumiendo que loteId es el identificador del lote actual
      "supplier": editSupplierController.value.text,
      "batch": int.parse(loteFilterController.value.text),
      "date": editDateController.value.text,
      "product": editProductController.value.text,
      "weight": {
        "value": double.tryParse(editPesoController.value.text) ?? 0,
        "units": editUnitsController.value.text,
      }
    };

    final payloadToUpdate = {
      "id": loteId, // Asumiendo que loteId es el identificador del lote actual
      "supplier": editSupplierController.value.text,
      "batch": int.parse(loteFilterController.value.text),
      "date": editDateController.value.text,
      "product": editProductController.value.text,
      "weight": double.tryParse(editPesoController.value.text) ?? 0,
      "weight_units": editUnitsController.value.text
    };

    int index = lotes.indexWhere((item) {
      print('Comparando: ${item} con $loteId');
      return item['id'] == loteId;
    });

    if (index != -1) {
      lotes[index] = Map<String, dynamic>.from(payloadToUpdate);
    }

    var dateSplit = fechaFilterController.value.text.split(" - ");
    final dateFrom = dateSplit[0];
    final dateTo = dateSplit[1];

    final storage = GetStorage();
    final storageKey =
        "lote_${int.parse(loteFilterController.value.text)}_${dateFrom}_$dateTo";

    await storage.write(storageKey, lotes);
    enqueueRequest('PUT', 'api/scale/${loteId}', payload);
  }

  void enqueueRequest(String method, String endpoint, payload) {
    final request = {
      'method': method,
      'endpoint': endpoint,
      "token": customToken,
      'body': payload
    };

    requestQueue.addRequest(request);

    Future.delayed(const Duration(seconds: 2), () {
      try {
        final batch = int.tryParse(loteFilterController.value.text);
        var dateSplit = fechaFilterController.value.text.split(" - ");

        if (batch != null && dateSplit.length == 2) {
          fetchLotes();
        } else {}
      } catch (e) {}
    });
  }

  void removeItem(String loteId) async {
    int index = lotes.indexWhere((item) {
      return item['id'] == loteId;
    });

    if (index != -1) {
      lotes.removeAt(index);

      var dateSplit = fechaFilterController.value.text.split(" - ");
      final dateFrom = dateSplit[0];
      final dateTo = dateSplit[1];

      final storageKey =
          "lote_${int.parse(loteFilterController.value.text)}_${dateFrom}_$dateTo";
      final storage = GetStorage();

      lotes.refresh();

      await storage.write(storageKey, lotes);
      final payload = {
        "id": loteId,
      };
      enqueueRequest('DELETE', 'api/scale/${loteId}', payload);

      logger.i("Item con id '$loteId' eliminado.");
    } else {
      logger.w("No se encontró un item con id '$loteId' en 'lotes'.");
    }
  }

  Future<void> loadItems(batch, dateFrom, dateTo) async {
    final storage = GetStorage();

    final storageKey = "lote_${batch}_${dateFrom}_$dateTo";

    var items = await storage.read(storageKey) as List<dynamic>;

    if (items.length == 0) {
      Get.defaultDialog(
        title: "Lotes",
        middleText: "No hay elementos que mostrar",
      );
    }
    lotes.value = items;
    print("estos son los items   ${items}");
  }

  Future<void> fetchLotesApi(batch, dateFrom, dateTo) async {
    final apiClient = Get.find<ApiClient>();
    apiClient.setToken(customToken);

    final payload = {
      "batch": int.parse(loteFilterController.value.text),
      "date_from": dateFrom,
      "date_to": dateTo
    };

    try {
      final response = await apiClient.get(
        'api/scale/search',
        body: payload,
      );

      print("este es el payload ${payload}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        var lotes = data.map<Map<String, dynamic>>((lote) {
          return {
            "id": lote['_id'],
            "date": lote['date'],
            "batch": lote['batch'].toString(),
            "weight": lote['weight']['value'],
            "weight_units": lote['weight']['units'],
            "supplier": lote['supplier'],
            "product": lote['product'],
          };
        }).toList();
        final storage = GetStorage();
        final storageKey = "lote_${batch}_${dateFrom}_$dateTo";

        print("estos son los lostes ${lotes}");
        await storage.write(storageKey, lotes);
      } else {
        print('Failed to load lotes: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching lotes: $e');
    }
  }

  Future<void> fetchLotes() async {
    try {
      final batch = int.parse(loteFilterController.value.text);

      // Split the date range
      var dateSplit = fechaFilterController.value.text.split(" - ");
      DateTime dateFrom = DateTime.parse(dateSplit[0]);
      DateTime dateTo = DateTime.parse(dateSplit[1]);

      // Ajustar fechas si son iguales (inicio y fin del mismo día)
      if (dateFrom.isAtSameMomentAs(dateTo)) {
        dateFrom = DateTime(dateFrom.year, dateFrom.month, dateFrom.day, 0, 0, 0); // Inicio del día
        dateTo = DateTime(dateTo.year, dateTo.month, dateTo.day, 23, 59, 59); // Fin del día
      } else {
        // Si son diferentes, ajustar el inicio del día 1 y fin del día 2
        dateFrom = DateTime(dateFrom.year, dateFrom.month, dateFrom.day, 0, 0, 0); // Inicio del día 1
        dateTo = DateTime(dateTo.year, dateTo.month, dateTo.day, 23, 59, 59); // Fin del día 2
      }

      // Comprobar si el dispositivo está en línea
      if (Get.find<ConnectivityService>().isOnline.value) {
        await fetchLotesApi(batch, dateFrom.toIso8601String(), dateTo.toIso8601String());
      }

      // Utilizar las cadenas formateadas para pasar las fechas
      loadItems(batch, dateFrom.toIso8601String(), dateTo.toIso8601String());
    } catch (e) {
      Get.defaultDialog(
        title: "Lotes",
        middleText: "Ingresar los filtros correctamente",
      );
    }
  }

}
