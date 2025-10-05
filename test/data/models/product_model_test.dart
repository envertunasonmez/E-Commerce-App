import 'package:flutter_test/flutter_test.dart';
import 'package:basic_e_commerce_app/data/models/product_model.dart';

void main() {
  group('Product Model Tests', () {
    test('Should create Product successfully from JSON', () {
      final json = {
        'id': 1,
        'title': 'Test Product',
        'image': 'https://example.com/image.png',
        'price': 99.99
      };

      final product = Product.fromJson(json);

      expect(product.id, 1);
      expect(product.title, 'Test Product');
      expect(product.image, 'https://example.com/image.png');
      expect(product.price, 99.99);
    });

    test('Should throw an error if a required field is missing', () {
      final invalidJson = {
        'id': 2,
        'title': 'Invalid Product',
        // 'image' field is missing
        'price': 50.0
      };

      expect(
        () => Product.fromJson(invalidJson),
        throwsA(isA<TypeError>()), // missing field throws TypeError
      );
    });

    test('Should throw an error if price is a string instead of double', () {
      final invalidJson = {
        'id': 3,
        'title': 'String Price',
        'image': 'https://example.com/img.png',
        'price': '99.99'
      };

      expect(
        () => Product.fromJson(invalidJson),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
