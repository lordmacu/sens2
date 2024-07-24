import 'package:get/get.dart';
import '../services/product_service.dart';
import '../../../core/services/connectivity_service.dart';
import '../../../core/services/request_queue_service.dart';

class ProductListController extends GetxController {
  final ProductService productService = Get.find<ProductService>();
  final ConnectivityService connectivityService = Get.find<ConnectivityService>();
  final RequestQueueService requestQueueService = Get.find<RequestQueueService>();

  var products = <dynamic>[].obs;
  var isLoading = true.obs;
  var isOnline = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    _subscribeToConnectivityChanges();
  }

  void _subscribeToConnectivityChanges() {
    connectivityService.isOnline.listen((online) {
      isOnline.value = online;
      if (online) {
        requestQueueService.processRequests();
      }
    });
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var productList = await productService.fetchProducts();
      products.assignAll(productList);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load products');
    } finally {
      isLoading(false);
    }
  }

  void addProduct(Map<String, dynamic> product) async {
    try {
      isLoading(true);
      await productService.createProduct(product);
      products.add(product);  // Opcional: Actualizar la lista localmente
      Get.snackbar('Success', 'Product added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add product');
    } finally {
      isLoading(false);
    }
  }

  void updateProduct(String id, Map<String, dynamic> product) async {
    try {
      isLoading(true);
      await productService.updateProduct(id, product);
      int index = products.indexWhere((p) => p['id'] == id);
      if (index != -1) {
        products[index] = product;
      }
      Get.snackbar('Success', 'Product updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update product');
    } finally {
      isLoading(false);
    }
  }

  void deleteProduct(String id) async {
    try {
      isLoading(true);
      await productService.deleteProduct(id);
      products.removeWhere((p) => p['id'] == id);
      Get.snackbar('Success', 'Product deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete product');
    } finally {
      isLoading(false);
    }
  }
}
