// lib/features/favorites/favorites_cubit.dart
import 'package:basic_e_commerce_app/data/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<List<Product>> {
  FavoritesCubit() : super([]);

  void toggleFavorite(Product product) {
    if (state.contains(product)) {
      emit(state.where((p) => p.id != product.id).toList());
    } else {
      emit([...state, product]);
    }
  }

  bool isFavorite(Product product) {
    return state.any((p) => p.id == product.id);
  }
}
