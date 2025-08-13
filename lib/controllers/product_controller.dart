import 'package:get/get.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductController extends GetxController {
  final ApiService api;
  ProductController(this.api);

  var products = <Product>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAll();
  }

  Future<void> fetchAll() async {
    isLoading.value = true;
    error.value = '';
    try {
      final list = await api.fetchProducts();
      products.assignAll(list);
    } catch (e) {
      error.value = 'Failed to load products';
    } finally {
      isLoading.value = false;
    }
  }
}
