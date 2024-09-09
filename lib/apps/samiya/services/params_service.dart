import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/services/api_client.dart';
import '../../../core/services/request_queue_service.dart';
import 'dart:convert';
import 'package:logger/logger.dart';

class ParamsService extends GetxService {
  final ApiClient apiClient = Get.find<ApiClient>();
  final requestQueueService = Get.find<RequestQueueService>();
  final Logger logger = Logger();

  Future<void> saveGroupedData(
      Map<String, List<Map<String, dynamic>>> groupedData) async {
    final storage = GetStorage();
    final List<String> categories = groupedData.keys.toList();

    for (var category in categories) {
      await storage.remove(category);
    }

    for (var category in groupedData.keys) {
      await storage.write(category, groupedData[category]);
    }
    await storage.write('categories', categories);
  }

  Future<Map<String, List<Map<String, dynamic>>>> loadParams() async {
    try {
      final groupedData = await fetchParams();
      await saveGroupedData(groupedData);
      return groupedData;
    } catch (e) {
      logger.e('Error fetching or saving params: $e');
      rethrow;
    }
  }

  Future<Map<String, List<Map<String, dynamic>>>> fetchParams() async {
    final response = await apiClient.get('api/paramsOrganizations/?organizationName=samiya&name');

    if (response.statusCode == 200) {
      logger.e('Error fetching or saving params: ${jsonDecode(response.body)}');

      final data = jsonDecode(response.body)['data'] as List<dynamic>;

      print("esto es el fetch params ${data}");
      final Map<String, List<Map<String, dynamic>>> groupedData = {};

      for (var item in data) {
        final name = item['name'] as String;
        final id = item['id'] as String;

         final fields = item['fields'] != null && item['fields'] is Map
            ? Map<String, dynamic>.from(item['fields'] as Map)
            : {};

        if (!groupedData.containsKey(name)) {
          groupedData[name] = [];
        }

        groupedData[name]!.add({
          'id': id,
          'fields': fields,
        });
      }

      return groupedData;
    } else {
      throw Exception('Failed to load params');
    }
  }

}