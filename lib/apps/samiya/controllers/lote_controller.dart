import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sens2/core/services/api_client.dart';

class LoteController extends GetxController {
  var lotes = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchLotes();
  }

  Future<void> fetchLotes() async {
    final apiClient = Get.find<ApiClient>();

    print("aquiii estoy ");

    // Construye el payload
    final payload = {
      "batch": "batch",
      "date_from": "2024-08-01",
      "date_to": "2024-08-31"
    };

    try {

      final queryParameters = payload.entries.map((e) => '${e.key}=${e.value}').join('&');
      final endpointWithQuery = '/api/scale/search?$queryParameters';
      final response = await apiClient.get(
        endpointWithQuery,
       );

      print("este es el response  ${response.statusCode}  ${endpointWithQuery}");

      if (response.statusCode == 200) {
        // Procesa la respuesta JSON
        final data = jsonDecode(response.body);

        // Actualiza la lista de lotes con la data recibida
        lotes.value = data['lotes']; // Asume que la API devuelve un array de lotes bajo la clave 'lotes'

      } else {
        // Manejo de errores
        print('Failed to load lotes: ${response.statusCode}');
      }
    } catch (e) {
      // Manejo de excepciones
      print('Error fetching lotes: $e');
    }
  }
}
