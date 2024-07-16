import 'package:get/get.dart';
import 'package:sens2/core/services/connectivity_service.dart';
import '../../../core/services/api_client.dart';
import '../../../core/services/request_queue_service.dart';
import 'dart:convert';

class ProductService extends GetxService {
  final ApiClient apiClient = Get.find<ApiClient>();
  final requestQueueService = Get.find<RequestQueueService>();

  Future<List<dynamic>> fetchProducts() async {
    final response = await apiClient.get('products');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> createProduct(Map<String, dynamic> product) async {
    final request = {
      'endpoint': 'products',
      'body': jsonEncode(product),
      'method': 'POST',
    };

    if (Get.find<ConnectivityService>().isOnline.value) {
      final response = await apiClient.post(
        request['endpoint']!,
        body: request['body'],
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to create product');
      }
    } else {
      requestQueueService.addRequest(request);
    }
  }

  Future<void> updateProduct(String id, Map<String, dynamic> product) async {
    final request = {
      'endpoint': 'products/$id',
      'body': jsonEncode(product),
      'method': 'PUT',
    };

    if (Get.find<ConnectivityService>().isOnline.value) {
      final response = await apiClient.put(
        request['endpoint']!,
        body: request['body'],
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update product');
      }
    } else {
      requestQueueService.addRequest(request);
    }
  }

  Future<void> deleteProduct(String id) async {
    final request = {
      'endpoint': 'products/$id',
      'method': 'DELETE',
    };

    if (Get.find<ConnectivityService>().isOnline.value) {
      final response = await apiClient.delete(request['endpoint']!);

      if (response.statusCode != 204) {
        throw Exception('Failed to delete product');
      }
    } else {
      requestQueueService.addRequest(request);
    }
  }
}
