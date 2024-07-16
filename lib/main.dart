import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sens2/apps/apliplast/views/impresion/impresion_page.dart';
 import 'package:wakelock/wakelock.dart';
import 'core/theme/app_theme.dart';
import 'core/services/auth_service.dart';
import 'core/services/api_client.dart';
import 'core/services/connectivity_service.dart';
import 'core/services/request_queue_service.dart';
import 'login/login_page.dart';
import 'apps/apliplast/apliplast_main.dart';
import 'settings/views/settings_page.dart';


import 'apps/apliplast/apliplast_main.dart' show getRoutesApiplast;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Wakelock.enable();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: appTheme,
      initialBinding: BindingsBuilder(() {
        final apiClient = Get.put(ApiClient());
        final storage = GetStorage();
        final serverUrl = storage.read('serverUrl') ?? 'http://localhost';
        final serverPort = storage.read('serverPort') ?? '3500';
        apiClient.setBaseUrl('$serverUrl:$serverPort/');

        Get.put(AuthService());
        Get.put(ConnectivityService());
        Get.put(RequestQueueService());
        // No inicializamos MqttService aquí
      }),
      initialRoute: '/impresion',

      getPages: [
        GetPage(name: '/', page: () => AuthWrapper()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/settings', page: () => SettingsPage()),
        ...getRoutesApiplast(),
      ],
    );
  }
}



class AuthWrapper extends StatelessWidget {
  final AuthService authService = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      if (authService.isLoggedIn.value) {
        final String appType = 'app1'; // Esto sería dinámico
        switch (appType) {
          case 'app1':
            return App1Main();
          case 'app2':
            return App1Main(); // Ajusta esto según sea necesario
          default:
            return Scaffold(
              body: Center(child: Text('Aplicación no encontrada')),
            );
        }
      } else {
        return LoginPage();
      }
    });
  }
}
