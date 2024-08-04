import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:get/get.dart';
import 'package:sens2/apps/samiya/bildings/catch_weight_binding.dart';
import 'package:sens2/apps/samiya/views/catch_weigth/catch_weight_page.dart';

import 'package:sens2/apps/samiya/views/samiya_table.dart/samiya_tara.dart';
import 'package:sens2/apps/samiya/bildings/tara_binding.dart';
import 'package:sens2/apps/apliplast/views/gatepage/gate_page.dart';

import 'package:sens2/apps/apliplast/bindings/gate_binding.dart';
import 'package:sens2/apps/apliplast/views/servidor/servidor_page.dart';
import 'package:sens2/core/services/foreground_service.dart';

import 'services/product_service.dart';
import 'controllers/product_list_controller.dart';
import '../../core/services/mqtt_service.dart';

class App2Main extends StatefulWidget {
  @override
  _App1MainState createState() => _App1MainState();
}

class _App1MainState extends State<App2Main> {
  final ForegroundTaskService _foregroundTaskService = ForegroundTaskService();

  @override
  void initState() {
    super.initState();

    Get.lazyPut<ProductService>(() => ProductService());
    Get.lazyPut<ProductListController>(() => ProductListController());
    Get.put(MqttService());

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _foregroundTaskService.requestPermissions();
      await _foregroundTaskService.initForegroundTask();
      _foregroundTaskService.startForegroundTask();

      if (await FlutterForegroundTask.isRunningService) {
        final newReceivePort = FlutterForegroundTask.receivePort;
        _foregroundTaskService.registerReceivePort(newReceivePort);
      }
    });
  }

  @override
  void dispose() {
    _foregroundTaskService.closeReceivePort();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WithForegroundTask(
      child: Scaffold(
        appBar: AppBar(title: Text('App 2 samiya')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome to App 2 samiya!'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed('/app1/products');
                },
                child: Text('Go to Product List'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Función para registrar las rutas específicas de app1
List<GetPage> getRoutesSamiya() {
  return [
   
    GetPage(
      name: '/samiyaTara',
      page: () => SamiyaTara(),
      transition: Transition.native,
      binding: TaraBinding(),
    ),
      GetPage(
      name: '/catchWeight',
      page: () => CatchWeight(), // Sin el parámetro onSubmit
      transition: Transition.native,
      binding: CatchWeightBinding(),
    ),
    GetPage(
      name: '/gateWay',
      page: () => GatewayPage(),
      transition: Transition.native,
      binding: GateBinding(),
    ),
    GetPage(
      name: '/server',
      page: () => ServidorPage(),
      transition: Transition.native,
      
    ),
  
    // Ruta para configuración MQTT
  ];
}
