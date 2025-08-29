class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double originalPrice;
  final String category;
  final String brand;
  final List<String> images;
  final double rating;
  final int reviewCount;
  final List<String> colors;
  final List<String> sizes;
  final bool isInStock;
  final bool isFeatured;
  final bool isOnSale;
  final int discount;
  final String material;
  final List<String> features;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.category,
    required this.brand,
    required this.images,
    required this.rating,
    required this.reviewCount,
    required this.colors,
    required this.sizes,
    required this.isInStock,
    required this.isFeatured,
    required this.isOnSale,
    required this.discount,
    required this.material,
    required this.features,
  });

  double get discountedPrice => originalPrice * (1 - discount / 100);
  bool get hasDiscount => discount > 0;
  String get mainImage => images.isNotEmpty ? images.first : '';
}

class Category {
  final String id;
  final String name;
  final String icon;
  final String image;
  final String description;
  final int productCount;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.image,
    required this.description,
    required this.productCount,
  });
}
