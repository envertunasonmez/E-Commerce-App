import 'package:basic_e_commerce_app/cubit/cart/cart_cubit.dart';
import 'package:basic_e_commerce_app/data/models/product_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CartCubit cartCubit;
  late Product product1;
  late Product product2;

  setUp(() {
    cartCubit = CartCubit();
    product1 = Product(
      id: 1,
      title: 'Product 1',
      image: 'image1.png',
      price: 10.0,
    );
    product2 = Product(
      id: 2,
      title: 'Product 2',
      image: 'image2.png',
      price: 20.0,
    );
  });

  tearDown(() {
    cartCubit.close();
  });

  test('initial state is empty list', () {
    expect(cartCubit.state, []);
  });

  blocTest<CartCubit, List<Product>>(
    'emits [product1] when addToCart is called with product1',
    build: () => cartCubit,
    act: (cubit) => cubit.addToCart(product1),
    expect: () => [
      [product1],
    ],
  );

  blocTest<CartCubit, List<Product>>(
    'emits [product1, product2] when addToCart is called with product1 and then product2',
    build: () => cartCubit,
    act: (cubit) {
      cubit.addToCart(product1);
      cubit.addToCart(product2);
    },
    expect: () => [
      [product1],
      [product1, product2],
    ],
  );

  blocTest<CartCubit, List<Product>>(
    'emits [empty list] when removeFromCart is called with product1',
    build: () => cartCubit,
    seed: () => [product1],
    act: (cubit) => cubit.removeFromCart(product1),
    expect: () => [[]],
  );

  blocTest<CartCubit, List<Product>>(
    'emits [] when clearCart is called',
    build: () => cartCubit,
    seed: () => [product1, product2],
    act: (cubit) => cubit.clearCart(),
    expect: () => [[]],
  );

  // Example of a failing test (trying to remove a product not in the cart)
  blocTest<CartCubit, List<Product>>(
    'does not emit any state when removeFromCart is called with a product not in cart',
    build: () => cartCubit,
    seed: () => [product1],
    act: (cubit) => cubit.removeFromCart(product2),
    expect: () => [], // No new state is emitted
  );
}
