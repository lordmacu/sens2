import 'dart:async';
import 'package:get/get.dart';
import '../services/params_service.dart';
import '../../../core/services/connectivity_service.dart';
import '../../../core/services/request_queue_service.dart';

class ParamsController extends GetxController {
  final ParamsService paramsService = Get.find<ParamsService>();
  final ConnectivityService connectivityService = Get.find<ConnectivityService>();
  final RequestQueueService requestQueueService = Get.find<RequestQueueService>();

  var isLoading = true.obs;
  var isOnline = true.obs;
  var categories = <String>[].obs;
  var categoryItems = <String, List<Map<String, dynamic>>>{}.obs;
  var pendingRequest = 0.obs;

  Timer? _requestTimer;

  @override
  void onInit() {
    super.onInit();

    //fetchParams();

   }

  void _subscribeToConnectivityChanges() {
    connectivityService.isOnline.listen((online) {
       isOnline.value = online;
      if (online) {
        requestQueueService.processRequests();
        startRequestProcessing();
      } else {
        _requestTimer?.cancel();
      }
    });
  }

  Future startRequestProcessing() async{

     _requestTimer?.cancel();

     _requestTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {

      if (isOnline.value) {
        if(!requestQueueService.isProcessing.value){
          requestQueueService.processRequests();
        }
      }
    });

    _subscribeToConnectivityChanges();
  }

  Future fetchParams() async {
    try {
      isLoading(true);

      var groupedParams = await paramsService.loadParams();
      categories.value = groupedParams.keys.toList();
      categoryItems.value = groupedParams;
    } catch (e) {
    //  Get.snackbar('Error', 'Failed to load params');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    _requestTimer?.cancel();
    super.onClose();
  }
}
