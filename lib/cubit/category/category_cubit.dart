import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:basic_e_commerce_app/data/repositories/product_repository.dart';

class CategoryCubit extends Cubit<List<String>> {
  final ProductRepository repository;

  CategoryCubit(this.repository) : super([]);

  Future<void> loadCategories() async {
    final categories = await repository.getCategories();
    emit(categories);
  }
}
