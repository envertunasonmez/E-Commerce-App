import 'package:basic_e_commerce_app/data/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<List<Product>> {
  CartCubit() : super([]);

  void addToCart(Product product) {
    emit([...state, product]);
  }

  void removeFromCart(Product product) {
    emit(state.where((p) => p.id != product.id).toList());
  }

  void clearCart() {
    emit([]);
  }
}
