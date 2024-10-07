import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
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

  var lote = "".obs;

  final RequestQueueService requestQueue = Get.put(RequestQueueService());
  var customToken = "877f21428132a6c9f3d55bb8163fcb24";
  final Logger logger = Logger();
  final GetStorage box = GetStorage();

  @override
  void onInit() {
    super.onInit();

    print("cuando carga el lote?");
    DateTime date = DateTime.now();

    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    // Asignar el valor formateado a ambas variables
    String dateFrom = formattedDate;
    String dateTo = formattedDate;
    fechaFilterController.value.text = "${dateFrom} - ${dateTo}";

     loteFilterController.value.text = box.read('lote') ?? '100';

    fetchLotes();
  }

  // Función para agregar un nuevo lote
  void sendData(String batch, String peso, String supplier, String product, String date) async {
    var uuid = const Uuid();
    String newId = uuid.v4();

    final fields = {
      "id": newId, // Asumiendo que loteId es el identificador del lote actual
      "batch": int.parse(batch),
      "weight": {"value": double.tryParse(peso) ?? 0, "units": "kg"},
      "supplier": supplier,
      "date": date,
      "product": product,
      "gateway_id": "SAM01001"
    };


    final payloadToAdd = {
      "id": newId, // Asumiendo que loteId es el identificador del lote actual
      "supplier": supplier,
      "batch": int.parse(batch),
      "date": date,
      "product": product,
      "weight": double.tryParse(peso) ?? 0,
      "weight_units": "kg",
      "is_new":true
    };

   await  enqueueRequest('POST', 'api/scale', fields);
    loteFilterController.value.text = batch;

    Get.snackbar('Éxito', 'Lote agregado correctamente',
        snackPosition: SnackPosition.BOTTOM);
    resetFields();

    lotes.add(payloadToAdd);
    lotes.refresh();

    var dateSplit = [];
    var dateFrom = "";
    var dateTo =  "";


    var dateSplitNew = date.split(" ");
    fechaFilterController.value.text = "${dateSplitNew[0]} - ${dateSplitNew[0]}";
    loteFilterController.value.text = batch;


    try{
      dateSplit = fechaFilterController.value.text.split(" - ");
      dateFrom = dateSplit[0];
      dateTo = dateSplit[1];
    }catch(e){
      dateFrom = date;
      dateTo = date;
    }

    final storage = GetStorage();


    final storageKey =
        "lote_${int.parse(loteFilterController.value.text)}_${dateFrom}_$dateTo";

    await storage.write(storageKey, lotes);
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

print("aquii modificando ${editLoteController.value.text}");
    final payload = {
      "_id": loteId, // Asumiendo que loteId es el identificador del lote actual
      "supplier": editSupplierController.value.text,
      "batch": int.parse(editLoteController.value.text),
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
      "batch": int.parse(editLoteController.value.text),
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
    await enqueueRequest('PUT', 'api/scale/${loteId}', payload);


    var dateSplit = [];
    var dateFrom = "";
    var dateTo =  "";


    var dateSplitNew = editDateController.value.text.split(" ");
    fechaFilterController.value.text = "${dateSplitNew[0]} - ${dateSplitNew[0]}";
    loteFilterController.value.text = lote.value;

    Future.delayed(Duration(seconds: 3000), () {
      fetchLotes();
    });

    try{
      dateSplit = fechaFilterController.value.text.split(" - ");
      dateFrom = dateSplit[0];
      dateTo = dateSplit[1];
    }catch(e){
      dateFrom = editDateController.value.text;
      dateTo = editDateController.value.text;
    }
    loteFilterController.value.text = editLoteController.value.text;


    final storage = GetStorage();
    final storageKey =
        "lote_${int.parse(loteFilterController.value.text)}_${dateFrom}_$dateTo";

    await storage.write(storageKey, lotes);
  }

  Future enqueueRequest(String method, String endpoint, payload) async {
    final request = {
      'method': method,
      'endpoint': endpoint,
      "token": customToken,
      'body': payload,
      'is_processing': false,
      'module': "lote",
    };

    requestQueue.addRequest(request);
   }

  setItemAfterCreate(index, item){
    lotes[index] = Map<String, dynamic>.from(item);


    lotes.refresh();
  }

  void removeItem(String loteId) async {
    int index = lotes.indexWhere((item) {
      return item['id'] == loteId;
    });

    if (index != -1) {
      lotes.removeAt(index);


      lotes.refresh();

      final payload = {
        "id": loteId,
      };
      enqueueRequest('DELETE', 'api/scale/${loteId}', payload);

      var dateSplit = fechaFilterController.value.text.split(" - ");
      final dateFrom = dateSplit[0];
      final dateTo = dateSplit[1];

      final storageKey =
          "lote_${int.parse(loteFilterController.value.text)}_${dateFrom}_$dateTo";
      final storage = GetStorage();

      logger.i("Item con id '$loteId' eliminado.");

      await storage.write(storageKey, lotes);

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

    print("este es el payload ${payload}");

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

      var service= Get.find<ConnectivityService>();
      await service.checkInternetAccess();
      if (Get.find<ConnectivityService>().isOnline.value) {
        await fetchLotesApi(batch, dateFrom.toIso8601String(), dateTo.toIso8601String());
      }

      // Utilizar las cadenas formateadas para pasar las fechas
      loadItems(batch, dateFrom.toIso8601String(), dateTo.toIso8601String());
     } catch (e) {

      print("aquiii hgay un error ${e}");
      Get.defaultDialog(
        title: "Lotes",
        middleText: "Ingresar los filtros correctamente",
      );
    }
  }

}
