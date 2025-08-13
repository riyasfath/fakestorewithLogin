import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Product p = Get.arguments as Product;
    return Scaffold(
      appBar: AppBar(title: Text(p.title, maxLines: 1, overflow: TextOverflow.ellipsis)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: 'p_${p.id}',
              child: Image.network(p.image, fit: BoxFit.contain, errorBuilder: (_, __, ___) {
                return const Icon(Icons.broken_image, size: 80);
              }),
            ),
          ),
          const SizedBox(height: 12),
          Text(p.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text('₹ ${p.price.toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(p.description),
        ],
      ),
    );
  }
}
