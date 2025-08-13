class Rating {
  final double rate;
  final int count;
  Rating({required this.rate, required this.count});

  factory Rating.fromJson(Map<String, dynamic> j) => Rating(
        rate: (j['rate'] as num?)?.toDouble() ?? 0.0,
        count: (j['count'] as num?)?.toInt() ?? 0,
      );
}

class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> j) => Product(
        id: (j['id'] as num).toInt(),
        title: (j['title'] ?? '') as String,
        price: (j['price'] as num?)?.toDouble() ?? 0.0,
        description: (j['description'] ?? '') as String,
        category: (j['category'] ?? '') as String,
        image: (j['image'] ?? '') as String,
        rating: j['rating'] is Map<String, dynamic>
            ? Rating.fromJson(j['rating'] as Map<String, dynamic>)
            : Rating(rate: 0, count: 0),
      );
}
