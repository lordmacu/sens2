import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sens2/apps/samiya/bildings/catch_weight_binding.dart';
import 'package:sens2/apps/samiya/controllers/catch_weight_controller.dart';
import 'package:sens2/apps/samiya/views/catch_weigth/catch_weight_page.dart';

import 'package:sens2/apps/samiya/views/gatepage/gate_page.dart';

import 'package:sens2/apps/apliplast/bindings/gate_binding.dart';
import 'package:sens2/apps/apliplast/views/servidor/servidor_page.dart';
import 'package:sens2/core/controllers/table_controller.dart';
import 'package:sens2/core/services/request_queue_service.dart';
//import 'package:sens2/core/services/foreground_service.dart';

import 'services/params_service.dart';
import 'controllers/param_list_controller.dart';

class App2Main extends StatefulWidget {
  const App2Main({super.key});

  @override
  _App1MainState createState() => _App1MainState();
}

class _App1MainState extends State<App2Main> {
  //final ForegroundTaskService _foregroundTaskService = ForegroundTaskService();
  final CatchWeightController catchWeightController =
  Get.put(CatchWeightController());

  final TableController tableController = Get.find<TableController>();
  final RequestQueueService requestQueueService = Get.put(RequestQueueService());


  final GetStorage box = GetStorage();

  @override
  void initState() {
    super.initState();

    initializeServerGatewayUrl();
    initializeLote();
    initializePallet();

    Get.lazyPut<ParamsService>(() => ParamsService());
    final ParamsController paramsController = Get.put(ParamsController());

    WidgetsBinding.instance.addPostFrameCallback((_) async {
     /* await _foregroundTaskService.requestPermissions();
      await _foregroundTaskService.initForegroundTask();
      _foregroundTaskService.startForegroundTask();

      if (await FlutterForegroundTask.isRunningService) {
        final newReceivePort = FlutterForegroundTask.receivePort;
        _foregroundTaskService.registerReceivePort(newReceivePort);
      }*/
      await paramsController.startRequestProcessing();
      await paramsController.fetchParams();
      catchWeightController.startTimer();
      //Get.toNamed('/catchWeight');
    });
  }

  void initializeLote() {
     String? storedLote = box.read('lote');

    if (storedLote == null || storedLote.isEmpty) {
       storedLote = '100';
      box.write('lote', storedLote);
    }

     catchWeightController.loteController.value = int.parse(storedLote);
  }

  // Inicializa el valor de serverGatewayUrl por defecto si no existe
  void initializeServerGatewayUrl() {
    String? storedServerUrl = box.read('serverGatewayUrl');

    print("aquiii esta el server gateway ${storedServerUrl}");
    if (storedServerUrl == null || storedServerUrl.isEmpty) {
      const defaultServerUrl = 'localhost'; // Valor por defecto
      box.write('serverGatewayUrl', defaultServerUrl);
    }
  }

  void initializePallet() {
    String? pallet = box.read('pallet');

     if (pallet == null || pallet.isEmpty) {
      const defaultServerUrl = '24'; // Valor por defecto
      box.write('pallet', pallet);
    }
  }


  @override
  void dispose() {
   // _foregroundTaskService.closeReceivePort();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
   /* return WithForegroundTask(
      child: CatchWeight(),
    );*/

    return CatchWeight();
  }
}

// Función para registrar las rutas específicas de app1
List<GetPage> getRoutesSamiya() {
  return [
    GetPage(
      name: '/catchWeight',
      page: () => CatchWeight(), // Sin el parámetro onSubmit
      transition: Transition.native,
      binding: CatchWeightBinding(),
    ),
    GetPage(
      name: '/gateWay',
      page: () =>   GatewayPage(),
      transition: Transition.native,
      binding: GateBinding(),
    ),
    GetPage(
      name: '/server',
      page: () => const ServidorPage(),
      transition: Transition.native,
    ),
  ];
}
