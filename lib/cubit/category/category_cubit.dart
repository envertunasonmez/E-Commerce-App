import 'package:basic_e_commerce_app/data/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<List<String>> {
  final ApiService api;
  CategoryCubit(this.api) : super([]);

  Future<void> loadCategories() async {
    final data = await api.fetchCategories();
    emit(List<String>.from(data));
  }
}
