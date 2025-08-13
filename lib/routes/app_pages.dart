import 'package:get/get.dart';
import '../services/api_service.dart';
import '../controllers/product_controller.dart';
import '../controllers/auth_controller.dart';
import '../views/login_page.dart';
import '../views/home_page.dart';
import '../views/product_detail_page.dart';
import '../routes/app_routes.dart';

class AppPages {
  static final api = ApiService();

  static final List<GetPage> pages = [
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<AuthController>()) {
          // Pass ApiService into AuthController for hardcoded login
          Get.put(AuthController());
        }
      }),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<ProductController>()) {
          Get.put(ProductController(api));
        }
      }),
    ),
    GetPage(
      name: Routes.detail,
      page: () => const ProductDetailPage(),
    ),
  ];
}
