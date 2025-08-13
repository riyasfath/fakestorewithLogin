import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/product.dart';
import '../../routes/app_routes.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(Routes.detail, arguments: product),
      child: Card(
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Hero(
                tag: 'p_${product.id}',
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(product.image, fit: BoxFit.contain, errorBuilder: (_, __, ___) {
                    return const Icon(Icons.image_not_supported_outlined, size: 48);
                  }),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 6),
                  Text('₹ ${product.price.toStringAsFixed(2)}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
