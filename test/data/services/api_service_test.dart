import 'dart:convert';
import 'package:basic_e_commerce_app/data/services/api_service.dart';
import 'package:basic_e_commerce_app/product/constants/network_constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockClient;
  late ApiService apiService;

  setUp(() {
    mockClient = MockHttpClient();
    apiService = ApiService();
  });

  group('ApiService Tests', () {
    test('fetchCategories returns a list of categories successfully', () async {
      // Arrange
      final mockResponse = jsonEncode([
        'electronics',
        'jewelery',
        'men clothing',
      ]);
      when(
        () => mockClient.get(
          Uri.parse("${NetworkConstants.baseUrl}/products/categories"),
        ),
      ).thenAnswer((_) async => http.Response(mockResponse, 200));

      // Override the client temporarily
      apiService = ApiServiceWithClient(mockClient);

      // Act
      final categories = await apiService.fetchCategories();

      // Assert
      expect(categories, isA<List<dynamic>>());
      expect(categories, equals(['electronics', 'jewelery', 'men clothing']));
      verify(
        () => mockClient.get(
          Uri.parse("${NetworkConstants.baseUrl}/products/categories"),
        ),
      ).called(1);
    });

    test('fetchCategories throws exception on failure', () async {
      // Arrange
      when(
        () => mockClient.get(
          Uri.parse("${NetworkConstants.baseUrl}/products/categories"),
        ),
      ).thenThrow(Exception('Network Error'));

      apiService = ApiServiceWithClient(mockClient);

      // Act & Assert
      expect(() => apiService.fetchCategories(), throwsException);
      verify(
        () => mockClient.get(
          Uri.parse("${NetworkConstants.baseUrl}/products/categories"),
        ),
      ).called(1);
    });

    test(
      'fetchProductsByCategory returns a list of products successfully',
      () async {
        // Arrange
        final category = 'electronics';
        final mockProducts = [
          {
            'id': 1,
            'title': 'Test Product',
            'image': 'img.png',
            'price': 99.99,
          },
        ];
        when(
          () => mockClient.get(
            Uri.parse(
              "${NetworkConstants.baseUrl}/products/category/$category",
            ),
          ),
        ).thenAnswer((_) async => http.Response(jsonEncode(mockProducts), 200));

        apiService = ApiServiceWithClient(mockClient);

        // Act
        final products = await apiService.fetchProductsByCategory(category);

        // Assert
        expect(products, isA<List<dynamic>>());
        expect(products.length, equals(1));
        expect(products[0]['title'], equals('Test Product'));
        verify(
          () => mockClient.get(
            Uri.parse(
              "${NetworkConstants.baseUrl}/products/category/$category",
            ),
          ),
        ).called(1);
      },
    );

    test('fetchProductsByCategory throws exception on failure', () async {
      // Arrange
      final category = 'electronics';
      when(
        () => mockClient.get(
          Uri.parse("${NetworkConstants.baseUrl}/products/category/$category"),
        ),
      ).thenThrow(Exception('Network Error'));

      apiService = ApiServiceWithClient(mockClient);

      // Act & Assert
      expect(
        () => apiService.fetchProductsByCategory(category),
        throwsException,
      );
      verify(
        () => mockClient.get(
          Uri.parse("${NetworkConstants.baseUrl}/products/category/$category"),
        ),
      ).called(1);
    });
  });
}

// Helper class to inject mock client
class ApiServiceWithClient extends ApiService {
  final http.Client client;
  ApiServiceWithClient(this.client);

  @override
  Future<List<dynamic>> fetchCategories() async {
    final res = await client.get(
      Uri.parse("${NetworkConstants.baseUrl}/products/categories"),
    );
    return jsonDecode(res.body);
  }

  @override
  Future<List<dynamic>> fetchProductsByCategory(String category) async {
    final encodedCategory = Uri.encodeComponent(category);
    final res = await client.get(
      Uri.parse(
        "${NetworkConstants.baseUrl}/products/category/$encodedCategory",
      ),
    );
    return jsonDecode(res.body);
  }
}
