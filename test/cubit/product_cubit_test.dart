import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:basic_e_commerce_app/cubit/product/product_cubit.dart';
import 'package:basic_e_commerce_app/cubit/product/product_state.dart';
import 'package:basic_e_commerce_app/data/models/product_model.dart';
import 'package:basic_e_commerce_app/data/repositories/product_repository.dart';

// Mock class for ProductRepository
class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late ProductCubit cubit;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    cubit = ProductCubit(mockRepository);
  });

  tearDown(() {
    cubit.close();
  });

  final mockProducts = [
    Product(id: 1, title: 'Product 1', image: 'url1', price: 10.0),
    Product(id: 2, title: 'Product 2', image: 'url2', price: 20.0),
  ];

  group('ProductCubit Tests', () {
    test('initial state is null', () {
      expect(cubit.state, null);
    });
blocTest<ProductCubit, ProductState?>(
  'emits ProductState with products when loadProducts is successful',
  build: () {
    when(() => mockRepository.getProductsByCategory('electronics'))
        .thenAnswer((_) async => mockProducts);
    return cubit;
  },
  act: (cubit) => cubit.loadProducts('electronics'),
  expect: () => [
    ProductState(category: 'electronics', products: mockProducts),
  ],
  verify: (_) {
    verify(() => mockRepository.getProductsByCategory('electronics')).called(1);
  },
);


    blocTest<ProductCubit, ProductState?>(
      'throws exception when repository fails',
      build: () {
        when(() => mockRepository.getProductsByCategory('electronics'))
            .thenThrow(Exception('Failed to fetch products'));
        return cubit;
      },
      act: (cubit) => cubit.loadProducts('electronics'),
      errors: () => [isA<Exception>()], // expecting an exception
    );
  });
}
