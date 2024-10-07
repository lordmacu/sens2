import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sens2/apps/apliplast/apliplast_main.dart';
import 'package:sens2/apps/samiya/controllers/lote_controller.dart';
import 'package:sens2/apps/samiya/views/gatepage/gate_page.dart';
import 'package:sens2/core/controllers/table_controller.dart';
import 'package:sens2/apps/samiya/views/lote/table_lote_page.dart';
import 'package:sens2/core/components/table/general_table.dart';
import 'package:sens2/core/bindings/table_binding.dart';
import 'package:wakelock/wakelock.dart';
import 'core/theme/app_theme.dart';
import 'core/services/auth_service.dart';
import 'core/services/api_client.dart';
import 'core/services/connectivity_service.dart';
import 'core/services/request_queue_service.dart';
import 'login/login_page.dart';
import 'apps/samiya/samiya_main.dart';
import 'settings/views/settings_page.dart';
 import 'apps/apliplast/views/servidor/servidor_page.dart';
 import 'package:sens2/apps/apliplast/views/impresion/impresion_page.dart';


//import 'apps/apliplast/apliplast_main.dart' show getRoutesApiplast;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Wakelock.enable();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: appTheme,
      initialBinding: BindingsBuilder(() {
        final apiClient = Get.put(ApiClient());
        final storage = GetStorage();
        final serverUrl = storage.read('serverUrl') ?? 'https://backend.senscloud.io';
        final serverPort = storage.read('serverPort') ?? '443';


        apiClient.setBaseUrl('$serverUrl:$serverPort/');
        Get.lazyPut<TableController>(() => TableController());
        Get.lazyPut<LoteController>(() => LoteController());



        Get.put(RequestQueueService());
        Get.put(AuthService());
        Get.put(ConnectivityService());

       }),
      initialRoute: '/', // Ajusta el initialRoute a '/'

      getPages: [
        GetPage(name: '/', page: () => AuthWrapper()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/settings', page: () => SettingsPage()),
         GetPage(
          name: '/generalTable',
          page: () => GeneralTable(),
          transition: Transition.native,
          binding: TableBinding(),
        ),
          GetPage(name: '/server', page: () => const ServidorPage()),
            GetPage(name: '/gateWay', page: () =>   GatewayPage()),
             GetPage(name: '/tableLote', page: () => const TableLotePage()),
              GetPage(name: '/impresion', page: () => const ImpresionPage()),


        ...getRoutesSamiya(),
        ...getRoutesApiplast(),
      ],
    );
  }
}

class AuthWrapper extends StatelessWidget {
  final AuthService authService = Get.find<AuthService>();
  var storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
    //  authService.logout();
      if (authService.isLoggedIn.value) {
        var appTypes = storage.read("organization").toLowerCase();

       //  String appType  = authService.organization.value.toLowerCase();
        //print("aquii esta la organizacion ${appType}");
        switch (appTypes) {
          case 'samiya':
            return const App2Main();
          case 'apliplast':
            return const App1Main(); // Asegúrate de redirigir correctamente a SamiyaTara
          default:
           return App2Main();
        }
      } else {
        return LoginPage();
      }
    });
  }
}
