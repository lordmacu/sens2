import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sens2/apps/samiya/views/catch_weigth/catch_weight_page.dart';
import 'package:wakelock/wakelock.dart';
import 'core/theme/app_theme.dart';
import 'core/services/auth_service.dart';
import 'core/services/api_client.dart';
import 'core/services/connectivity_service.dart';
import 'core/services/request_queue_service.dart';
import 'login/login_page.dart';
import 'apps/apliplast/apliplast_main.dart';
import 'settings/views/settings_page.dart';
import 'apps/samiya/views/samiya_table.dart/samiya_tara.dart';
import 'apps/apliplast/views/servidor/servidor_page.dart';
import 'apps/apliplast/views/gatepage/gate_page.dart';

//import 'apps/apliplast/apliplast_main.dart' show getRoutesApiplast;
import 'apps/samiya/samiya_main.dart' show getRoutesSamiya;
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
      initialRoute: '/samiyaTara', // Ajusta el initialRoute a '/'
      getPages: [
        GetPage(name: '/', page: () => AuthWrapper()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/settings', page: () => SettingsPage()),
        GetPage(name: '/samiyaTara', page: () => SamiyaTara()),
          GetPage(name: '/server', page: () => ServidorPage()),
            GetPage(name: '/gateWay', page: () => GatewayPage()),
         GetPage(name: '/catchWeight', page: () => CatchWeight()), 
        ...getRoutesSamiya(),
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
        final String appType = 'app2'; 
        switch (appType) {
          case 'app1':
            return App1Main();
          case 'app2':
            return SamiyaTara(); // Asegúrate de redirigir correctamente a SamiyaTara
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
