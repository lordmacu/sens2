import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/services/api_client.dart';
import '../../../core/services/request_queue_service.dart';
import 'dart:convert';

class ParamsService extends GetxService {
  final ApiClient apiClient = Get.find<ApiClient>();
  final requestQueueService = Get.find<RequestQueueService>();

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
      print('Error fetching or saving params: $e');
      throw e;
    }
  }

  Future<Map<String, List<Map<String, dynamic>>>> fetchParams() async {
    final response = await apiClient.get(
        'api/paramsOrganizations/?organizationName=samiya&name');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'] as List<dynamic>;

      final Map<String, List<Map<String, dynamic>>> groupedData = {};

      for (var item in data) {
        final name = item['name'] as String;
        final id = item['id'] as String;
        final fields = item['fields'] as Map<String, dynamic>;

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
