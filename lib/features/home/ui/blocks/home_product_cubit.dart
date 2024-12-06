import 'package:bloc/bloc.dart';
import '../../../../network/network_handler.dart';

// Product model
class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String thumbnail;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.thumbnail,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0, // Provide a default value for ID
      title: json['title'] ?? 'Untitled', // Default to "Untitled" if null
      description: json['description'] ?? 'No description available',
      category: json['category'] ?? 'Unknown category',
      price: (json['price'] ?? 0).toDouble(),
      discountPercentage: (json['discountPercentage'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      brand: json['brand'] ?? 'Unknown brand',
      thumbnail: json['thumbnail'] ?? '', 
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : [], 
    );
  }
}

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  ProductLoaded(this.products);
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}

class ProductCubit extends Cubit<ProductState> {
  final NetworkHandler networkHandler;

  ProductCubit(this.networkHandler) : super(ProductInitial());

  Future<void> fetchProducts() async {
    try {
      emit(ProductLoading());

      final response = await networkHandler.get(
          'https://dummyjson.com/products',
          queryParameters: {'limit': 10, 'skip': 10});

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> productList = response.data['products'];
        final products =
            productList.map((json) => Product.fromJson(json)).toList();

        emit(ProductLoaded(products));
      } else {
        emit(ProductError('Failed to load products'));
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
