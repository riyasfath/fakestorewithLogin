import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';

  Future<String?> login(String username, String password) async {
    try {
      final url = Uri.parse('$baseUrl/auth/login');
      final res = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'username': username.trim(), 'password': password}),
          )
          .timeout(const Duration(seconds: 15));

      if (res.statusCode == 200) {
        final map = jsonDecode(res.body) as Map<String, dynamic>;
        return (map['token'] as String?) ?? '';
      } else if (res.statusCode == 401) {
        return null; // invalid credentials
      } else {
        throw Exception('HTTP ${res.statusCode}: ${res.body}');
      }
    } on Exception catch (e) {
      throw Exception('Network/Login error: $e');
    }
  }

  Future<List<Product>> fetchProducts() async {
    final url = Uri.parse('$baseUrl/products');
    final res = await http.get(url).timeout(const Duration(seconds: 20));
    if (res.statusCode == 200) {
      final list = (jsonDecode(res.body) as List)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList();
      return list;
    }
    throw Exception('Failed to load products (HTTP ${res.statusCode})');
  }

  Future<Product> fetchProduct(int id) async {
    final url = Uri.parse('$baseUrl/products/$id');
    final res = await http.get(url).timeout(const Duration(seconds: 20));
    if (res.statusCode == 200) {
      final map = jsonDecode(res.body) as Map<String, dynamic>;
      return Product.fromJson(map);
    }
    throw Exception('Failed to load product (HTTP ${res.statusCode})');
  }
}
