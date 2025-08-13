import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'controllers/product_controller.dart';
import 'services/api_service.dart';

void main() {
  // Initialize dependencies for products (Auth is bound in the login route)
  final apiService = ApiService();
  if (!Get.isRegistered<ProductController>()) {
    Get.put(ProductController(apiService));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FakeStore',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: Routes.login,
      getPages: AppPages.pages,
    );
  }
}
