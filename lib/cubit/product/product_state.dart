import 'package:basic_e_commerce_app/data/models/product_model.dart';

class ProductState {
  final String category;
  final List<Product> products;

  ProductState({required this.category, required this.products});
}
