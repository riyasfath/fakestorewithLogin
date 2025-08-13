import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  static const allowedUsername = 'mor_2314';
  static const allowedPassword = '83r5^_';

  var isLoading = false.obs;
  var error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    tryAutoLogin();
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null && token.isNotEmpty) {
      Get.offAllNamed(Routes.home);
    }
  }

  Future<void> login(String username, String password) async {
    isLoading.value = true;
    error.value = '';
    try {
      if (username.trim() == allowedUsername && password == allowedPassword) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', 'local_token');
        Get.offAllNamed(Routes.home);
      } else {
        error.value = 'Invalid username or password';
      }
    } catch (e) {
      error.value = 'Login failed';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Get.offAllNamed(Routes.login);
  }
}
