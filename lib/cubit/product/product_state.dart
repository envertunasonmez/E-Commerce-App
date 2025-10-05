import 'package:equatable/equatable.dart';
import 'package:basic_e_commerce_app/data/models/product_model.dart';

class ProductState extends Equatable {
  final String category;
  final List<Product> products;

  const ProductState({required this.category, required this.products});

  @override
  List<Object?> get props => [category, products];
}
