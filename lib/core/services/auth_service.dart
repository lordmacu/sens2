import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'api_client.dart';
import 'dart:convert';

class AuthService extends GetxService {
  final ApiClient apiClient = Get.find<ApiClient>();
  final storage = GetStorage();
  final Logger logger = Logger(); // Instancia de Logger

  var isLoggedIn = false.obs;
  var user = Rxn<Map<String, dynamic>>();
  var token = ''.obs;
  var isLoggedInProcess = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkAuthStatus();
  }

  Future<void> login(String username, String password) async {
    final response = await apiClient.post(
      'api/users/signin',
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    logger.i("Respuesta del servidor: ${response.body}");
    logger.i("Datos enviados: ${{
      'username': username,
      'password': password,
    }}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      token.value = data['token'];
      apiClient.setToken(token.value);
      storage.write('token', data['token']);
      storage.write('message', data['message']);
      storage.write('username', username);
      storage.write('password', password);
      userInformation(token.value, username);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> userInformation(String token, String username) async {
    final response = await apiClient.get(
      'api/users/profile/information?select=construction&select=organization&select=variable',
      headers: {
        'Content-Type': 'application/json',
        'access-token': token,
      },
    );

    try {
      var body = jsonDecode(response.body);
      storage.write('organization', body['data']['organization']);
      isLoggedIn.value = true;
    } catch (e) {
      logger.e("Error al obtener información del usuario: $e");
    }
  }

  Future<void> logout() async {
    isLoggedIn.value = false;
    user.value = null;
    token.value = '';
    apiClient.setToken('');
    storage.erase();
  }

  void checkAuthStatus() {
    final storedToken = storage.read('token');
    if (storedToken != null) {
      token.value = storedToken;
      apiClient.setToken(token.value);
      user.value = storage.read('user');
      isLoggedIn.value = true;
    } else {
      isLoggedIn.value = false;
    }
  }

  Future<void> loginOffline(String username, String password) async {
    final storedUsername = storage.read('username');
    final storedPassword = storage.read('password');

    if (username == storedUsername && password == storedPassword) {
      token.value = storage.read('token');
      user.value = storage.read('user');
      isLoggedIn.value = true;
    } else {
      throw Exception('Invalid credentials for offline login');
    }
  }
}