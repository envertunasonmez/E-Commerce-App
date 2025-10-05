import 'package:basic_e_commerce_app/data/models/product_model.dart';
import 'package:basic_e_commerce_app/data/services/api_service.dart';

class ProductRepository {
  final ApiService api;

  ProductRepository(this.api);

  Future<List<String>> getCategories() async {
    final data = await api.fetchCategories();
    return List<String>.from(data);
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    final data = await api.fetchProductsByCategory(category);
    return data.map((e) => Product.fromJson(e)).toList();
  }
}
