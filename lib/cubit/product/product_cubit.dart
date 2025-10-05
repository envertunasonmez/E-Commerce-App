import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:basic_e_commerce_app/data/repositories/product_repository.dart';
import 'package:basic_e_commerce_app/cubit/product/product_state.dart';

class ProductCubit extends Cubit<ProductState?> {
  final ProductRepository repository;

  ProductCubit(this.repository) : super(null);

  Future<void> loadProducts(String category) async {
    final products = await repository.getProductsByCategory(category);
    emit(ProductState(category: category, products: products));
  }
}
