import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:sens2/apps/samiya/models/weight.dart';
import 'package:sens2/core/services/request_queue_service.dart';

class CatchWeightController extends GetxController {
  final logger = Logger(); // Instancia de Logger

  // Controladores para los campos de texto
  var palletController = TextEditingController().obs;
  var supplierController = TextEditingController().obs;
  var materialController = TextEditingController().obs;
  var materiaPrima = TextEditingController().obs;
  var lotController = TextEditingController().obs; // Ejemplo para 'Lote'

  // Otros controladores si son necesarios
  var operatorController = TextEditingController().obs;
  var netWeightController = TextEditingController().obs;
  var grossWeightController = TextEditingController().obs;
  final RequestQueueService requestQueue = Get.put(RequestQueueService());

  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    // Comienza a hacer la petición cada 2 segundos
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) => fetchWeight());
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  Future<void> fetchWeight() async {
    try {
      // Simular un retardo para emular una llamada a la API
      await Future.delayed(Duration(milliseconds: 1000));
      Random random = Random();

      double randomWeight = 100 + random.nextDouble() * 100; // Valor entre 100 y 200 kg

      // Crear un objeto JSON simulado
      final mockResponse = {
        "status": "OK",
        "weight": {
          "value": randomWeight,
          "units": "kg"
        }
      };

      // Procesar el estado y el peso
      String status = mockResponse['status'] as String;
      if (status == 'OK' && mockResponse['weight'] != null) {
        Weight weight = Weight.fromJson(mockResponse['weight'] as Map<String, dynamic>);

        // Actualizar el texto con dos decimales
        netWeightController.update((controller) {
          controller!.text = weight.value!.toStringAsFixed(2); // Formatea a dos decimales
        });
        grossWeightController.update((controller) {
          controller!.text = weight.units ?? '';
        });

        logger.i('Net Weight updated: ${netWeightController.value.text}');
        logger.i('Gross Weight updated: ${grossWeightController.value.text}');
      } else {
        logger.e('Received status: $status');
      }
    } catch (e) {
      logger.e('Error fetching weight: $e');
    }
  }

  // Función para enviar el JSON utilizando enqueueRequest
  void sendData() {
    final fields = toJson();

    enqueueRequest('POST',  'api/scale', fields);
  }

  // Función que realiza la encolación de la solicitud
  void enqueueRequest(String method, String endpoint, item) {
    final request = {
      'method': method,
      'endpoint': endpoint,
      'body': {
        "organization": "samiya",
        "name": "catch_weight", // Puedes ajustar este nombre según sea necesario
        "fields": item
      }
    };

    requestQueue.addRequest(request);
    requestQueue.processRequests();
  }

  Map<String, dynamic> toJson() {
    return {
      "createdAt": DateTime.now().toIso8601String(),
      "state": "activo",
      "id": "12345",
      "updatedAt": DateTime.now().toIso8601String(),
      "weight": {
        "netWeight": netWeightController.value.text,
        "grossWeight": grossWeightController.value.text
      },
      "batch": lotController.value.text,
      "supplier": supplierController.value.text,
      "product": materialController.value.text,
      "pallet": palletController.value.text,
      "quantityTara": operatorController.value.text,
      "tara": operatorController.value.text,
    };
  }


  Future<void> fetchWeightr() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.0.1:3500/api/scale'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Procesar el estado y el peso
        String status = data['status'] as String;
        if (status == 'OK' && data['weight'] != null) {
          Weight weight = Weight.fromJson(data['weight'] as Map<String, dynamic>);
          netWeightController.value.text = weight.value.toString();
          grossWeightController.value.text = weight.units ?? '';
          logger.i('Net Weight updated: ${netWeightController.value.text}');
          logger.i('Gross Weight updated: ${grossWeightController.value.text}');
        } else {
          logger.e('Received status: $status');
        }
      } else {
        logger.e('Error: ${response.statusCode}');
      }
    } catch (e) {
      logger.e('Error fetching weight: $e');
    }
  }

  void send() {

    sendData();
    logger.i('Pallet: ${palletController.value.text}');
    logger.i('Supplier: ${supplierController.value.text}');
    logger.i('Material: ${materialController.value.text}');
    logger.i('Lot: ${lotController.value.text}');
    logger.i('Operator: ${operatorController.value.text}');
    logger.i('Net Weight: ${netWeightController.value.text}');
    logger.i('Gross Weight: ${grossWeightController.value.text}');
  }
}
