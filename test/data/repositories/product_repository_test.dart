import 'package:basic_e_commerce_app/data/models/product_model.dart';
import 'package:basic_e_commerce_app/data/repositories/product_repository.dart';
import 'package:basic_e_commerce_app/data/services/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late MockApiService mockApi;
  late ProductRepository repository;

  setUp(() {
    mockApi = MockApiService();
    repository = ProductRepository(mockApi);
  });

  group('ProductRepository Tests', () {
    final mockCategories = ['electronics', 'jewelery', 'men clothing'];
    final mockProductsJson = [
      {
        'id': 1,
        'title': 'Test Product',
        'image': 'https://example.com/image.png',
        'price': 99.99
      },
      {
        'id': 2,
        'title': 'Another Product',
        'image': 'https://example.com/img2.png',
        'price': 49.99
      },
    ];

    test('getCategories returns a list of categories successfully', () async {
      // Arrange
      when(() => mockApi.fetchCategories()).thenAnswer((_) async => mockCategories);

      // Act
      final categories = await repository.getCategories();

      // Assert
      expect(categories, isA<List<String>>());
      expect(categories, equals(mockCategories));
      verify(() => mockApi.fetchCategories()).called(1);
    });

    test('getCategories throws an exception on failure', () async {
      // Arrange
      when(() => mockApi.fetchCategories()).thenThrow(Exception('API Error'));

      // Act & Assert
      expect(() => repository.getCategories(), throwsException);
      verify(() => mockApi.fetchCategories()).called(1);
    });

    test('getProductsByCategory returns a list of Product successfully', () async {
      // Arrange
      const category = 'electronics';
      when(() => mockApi.fetchProductsByCategory(category))
          .thenAnswer((_) async => mockProductsJson);

      // Act
      final products = await repository.getProductsByCategory(category);

      // Assert
      expect(products, isA<List<Product>>());
      expect(products.length, equals(2));
      expect(products[0].title, equals('Test Product'));
      verify(() => mockApi.fetchProductsByCategory(category)).called(1);
    });

    test('getProductsByCategory throws an exception on failure', () async {
      // Arrange
      const category = 'electronics';
      when(() => mockApi.fetchProductsByCategory(category))
          .thenThrow(Exception('API Error'));

      // Act & Assert
      expect(() => repository.getProductsByCategory(category), throwsException);
      verify(() => mockApi.fetchProductsByCategory(category)).called(1);
    });
  });
}
