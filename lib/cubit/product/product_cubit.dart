import 'package:basic_e_commerce_app/cubit/product/product_state.dart';
import 'package:basic_e_commerce_app/data/models/product_model.dart';
import 'package:basic_e_commerce_app/data/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState?> {
  final ApiService api;
  ProductCubit(this.api) : super(null);

  Future<void> loadProducts(String category) async {
    final data = await api.fetchProductsByCategory(category);
    final products = (data as List).map((e) => Product.fromJson(e)).toList();
    emit(ProductState(category: category, products: products));
  }
}
