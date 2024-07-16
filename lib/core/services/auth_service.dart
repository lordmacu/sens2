import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'api_client.dart';
import 'dart:convert';

class AuthService extends GetxService {
  final ApiClient apiClient = Get.find<ApiClient>();
  final storage = GetStorage();

  var isLoggedIn = false.obs;
  var user = Rxn<Map<String, dynamic>>();
  var token = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkAuthStatus();
  }

  Future<void> login(String username, String password) async {
    final response = await apiClient.post(
      'login',
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      user.value = data['user'];
      token.value = data['token'];
      apiClient.setToken(token.value);
      isLoggedIn.value = true;
      storage.write('user', data['user']);
      storage.write('token', data['token']);
      storage.write('username', username);
      storage.write('password', password);
    } else {
      throw Exception('Failed to login');
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
