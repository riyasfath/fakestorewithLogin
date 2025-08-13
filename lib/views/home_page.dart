import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import '../controllers/auth_controller.dart';
import 'widgets/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final productCtrl = Get.find<ProductController>();
    final authCtrl = Get.find<AuthController>();
    const greenColor = Color(0xFF2ECC71);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor,
        title: const Text('Products', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              authCtrl.logout();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (productCtrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (productCtrl.error.isNotEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                productCtrl.error.value,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }
        final items = productCtrl.products;
        if (items.isEmpty) {
          return const Center(child: Text('No products'));
        }
        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.70,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: items.length,
          itemBuilder: (context, i) => ProductCard(product: items[i]),
        );
      }),
    );
  }
}
