import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/bindings/extrusion_report_binding.dart';

import 'package:sens2/apps/apliplast/bindings/imprimir_binding.dart';
import 'package:sens2/apps/apliplast/bindings/end_work_binding.dart';
import 'package:sens2/apps/apliplast/bindings/print_ticket_binding.dart';

import 'package:sens2/apps/apliplast/views/impresion/end_work.dart';
import 'package:sens2/apps/apliplast/views/impresion/extrusion_end_work.dart';
import 'package:sens2/apps/apliplast/views/impresion/extrusion_print_ticket.dart';
import 'package:sens2/apps/apliplast/views/impresion/print_ticket.dart';
import 'package:sens2/apps/apliplast/views/extrusion_report/extrusion_page.dart';

import 'package:sens2/apps/apliplast/views/impresion/impresion_page.dart';
import 'package:sens2/apps/apliplast/views/impresion/sealed_end_work.dart';
import 'package:sens2/apps/apliplast/views/impresion/sealed_print_ticket.dart';

import 'package:sens2/core/services/foreground_service.dart';

import 'services/product_service.dart';
import 'controllers/product_list_controller.dart';
import '../../core/services/mqtt_service.dart';

class App1Main extends StatefulWidget {
  @override
  _App1MainState createState() => _App1MainState();
}

class _App1MainState extends State<App1Main> {
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
        appBar: AppBar(title: Text('App 1')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome to App 1!'),
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
List<GetPage> getRoutesApiplast() {
  return [
    GetPage(name: '/app1', page: () => App1Main()),
    GetPage(
      name: '/endWork',
      page: () => EndWork(),
      transition: Transition.native,
      binding: EndWorkBinding(),
    ),
    GetPage(
      name: '/printTicket',
      page: () => PrintTicket(),
      transition: Transition.native,
      binding: PrintTicketBinding(),
    ),
    GetPage(
      name: '/printExtrusionTicket',
      page: () => ExtrusionPrintTicket(),
      transition: Transition.native,
      binding: PrintTicketBinding(),
    ),
    GetPage(
      name: '/extrusionEndWork',
      page: () => ExtrusionEndWork(),
      transition: Transition.native,
      binding: PrintTicketBinding(),
    ),
    GetPage(
      name: '/extrusionReport',
      page: () => ExtrusionReport(),
      transition: Transition.native,
      binding: ExtrusionReportBinding(),
    ),
     GetPage(
      name: '/sealedPrintTicket',
      page: () => SealedPrintTicket(),
      transition: Transition.native,
      binding: PrintTicketBinding(),
    ),
    GetPage(
      name: '/sealedEndWork',
      page: () => SealedEndWork(), 
      transition: Transition.native,
      binding: EndWorkBinding(),
    ),

    
    GetPage(
      name: '/impresion',
      page: () => ImpresionPage(),
      transition: Transition.native,
      binding: ImprimirBinding(),
    ),

    // Ruta para configuración MQTT
  ];
}
