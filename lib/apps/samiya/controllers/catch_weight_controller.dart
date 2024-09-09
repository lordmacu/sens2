import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
  var materialWeight = 0.0.obs;
  var material = "".obs;
  // Otros controladores si son necesarios
  var operatorController = TextEditingController().obs;
  var netWeightController = TextEditingController().obs;
  var grossWeightController = TextEditingController().obs;

  var weigthPrincipal =0.obs;
  var loteController = 0.obs;
  final RequestQueueService requestQueue = Get.put(RequestQueueService());
  var customToken = "877f21428132a6c9f3d55bb8163fcb24";
  final GetStorage box = GetStorage();

  Timer? timer;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  double _parseDouble(String value) {
    return double.tryParse(value) ?? 0.0;
  }

  double getPesoNeto() {
    double netWeight = _parseDouble(netWeightController.value.text);
    double palletValue = _parseDouble(palletController.value.text);
    double materialWeightValue = materialWeight.value;
    double operatorValue = _parseDouble(operatorController.value.text);

    // Verifica si todos los valores son mayores a cero
    if (palletValue > 0 && materialWeightValue > 0 && operatorValue > 0) {
      return (netWeight - palletValue - (materialWeightValue * operatorValue));
    } else {
      return 0.0; // Retorna 0 si alguno de los valores es 0 o negativo
    }
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) => fetchWeightr());
  }

  Future<void> fetchWeight() async {
    try {
      // Simular un retardo para emular una llamada a la API
      await Future.delayed(Duration(milliseconds: 1000));
      Random random = Random();

      double randomWeight =
          100 + random.nextDouble() * 100; // Valor entre 100 y 200 kg

      // Crear un objeto JSON simulado
      final mockResponse = {
        "status": "OK",
        "weight": {"value": 545, "units": "kg"}
      };

      // Procesar el estado y el peso
      String status = mockResponse['status'] as String;
      if (status == 'OK' && mockResponse['weight'] != null) {
        Weight weight =
            Weight.fromJson(mockResponse['weight'] as Map<String, dynamic>);

        // Actualizar el texto con dos decimales
        netWeightController.update((controller) {
          controller!.text =
              weight.value!.toStringAsFixed(2); // Formatea a dos decimales
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

   void sendData() {
    final fields = toJson();

    enqueueRequest('POST', 'api/scale', fields);
  }

  Map<String, dynamic> toJson() {
    return {
      "batch": (loteController.value),
      "weight": {"value": getPesoNeto(), "units": "kg"},
      "supplier": supplierController.value.text,
      "date": DateTime.now().toIso8601String(),
      "product": materiaPrima.value.text,
      "gateway_id": "SAM01001"
    };
  }

  // Función que realiza la encolación de la solicitud
  void enqueueRequest(String method, String endpoint, item) {
    final request = {
      'method': method,
      'endpoint': endpoint,
      'body': item,
      "token": customToken,
    };

    requestQueue.addRequest(request);

    resetFields();
    Get.snackbar('Éxito', 'Datos enviados correctamente',
        snackPosition: SnackPosition.BOTTOM);
  }

  void resetFields() {
     supplierController.value.text = '';
    materialController.value.text = '';
    materiaPrima.value.text = '';
    lotController.value.text = '';
    operatorController.value.text = '';
    netWeightController.value.text = '';
    grossWeightController.value.text = '';
  }



  Future<void> fetchWeightr() async {
     var serverGatewayUrl = box.read('serverGatewayUrl');
    // var serverGatewayUrl ="192.168.2.18";
    try {
      final response =
          await http.get(Uri.parse('http://$serverGatewayUrl:3500/api/scale'));

      if (response.statusCode == 200) {
        try {
          final data = json.decode(response.body);


          // Verificar que el JSON contenga las claves y valores esperados
          if (data is Map<String, dynamic> &&
              data.containsKey('status') &&
              data.containsKey('weight')) {
            String status = data['status'] as String;

            if (status == 'Ok' && data['weight'] != null) {
              // Asegurarse de que 'weight' es un Map y contiene los campos esperados
              if (data['weight'] is Map<String, dynamic>) {
                Weight weight =
                    Weight.fromJson(data['weight'] as Map<String, dynamic>);
                // Solo setear las variables si los datos no son nulos
                netWeightController.update((controller) {
                  controller!.text =
                      weight.value!.toStringAsFixed(2); // Formatea a dos decimales
                });
                grossWeightController.update((controller) {
                  controller!.text = "kg" ?? '';
                });

                logger
                    .i('Net Weight updated: ${netWeightController.value.text}');
                logger.i(
                    'Gross Weight updated: ${grossWeightController.value.text}');
              } else {
                logger.e('Weight data is not a valid Map');
              }
            } else {
              logger.e('Received status: $status or weight is null');
            }
          } else {
            logger.e('Invalid or incomplete JSON response');
          }
        } catch (e) {
          logger.e('Error parsing JSON: $e');
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
  }
}
