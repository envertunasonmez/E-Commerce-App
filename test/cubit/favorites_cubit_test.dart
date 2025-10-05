import 'package:basic_e_commerce_app/cubit/favorites/favorites_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:basic_e_commerce_app/data/models/product_model.dart';

void main() {
  late FavoritesCubit favoritesCubit;
  final product1 = Product(id: 1, title: 'Product 1', image: 'image1.png', price: 10.0);
  final product2 = Product(id: 2, title: 'Product 2', image: 'image2.png', price: 20.0);

  setUp(() {
    favoritesCubit = FavoritesCubit();
  });

  tearDown(() {
    favoritesCubit.close();
  });

  group('FavoritesCubit Tests', () {
    blocTest<FavoritesCubit, List<Product>>(
      'emits [product1] when a new product is added to favorites',
      build: () => favoritesCubit,
      act: (cubit) => cubit.toggleFavorite(product1),
      expect: () => [
        [product1],
      ],
    );

    blocTest<FavoritesCubit, List<Product>>(
      'removes product from favorites when toggled again',
      build: () => favoritesCubit,
      seed: () => [product1],
      act: (cubit) => cubit.toggleFavorite(product1),
      expect: () => [
        [],
      ],
    );

    blocTest<FavoritesCubit, List<Product>>(
      'emits multiple products when multiple products are added',
      build: () => favoritesCubit,
      act: (cubit) {
        cubit.toggleFavorite(product1);
        cubit.toggleFavorite(product2);
      },
      expect: () => [
        [product1],
        [product1, product2],
      ],
    );

    test('isFavorite returns true if product is in favorites', () {
      favoritesCubit.emit([product1]);
      expect(favoritesCubit.isFavorite(product1), isTrue);
    });

    test('isFavorite returns false if product is not in favorites', () {
      favoritesCubit.emit([product1]);
      expect(favoritesCubit.isFavorite(product2), isFalse);
    });
  });
}
