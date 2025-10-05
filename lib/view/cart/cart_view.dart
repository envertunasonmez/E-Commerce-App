import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:basic_e_commerce_app/cubit/cart/cart_cubit.dart';
import 'package:basic_e_commerce_app/data/models/product_model.dart';
import 'widgets/cart_empty.dart';
import 'widgets/cart_item_card.dart';
import 'widgets/cart_summary.dart';
import 'widgets/success_dialog.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  void _showSuccessDialog(BuildContext context, CartCubit cubit) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => SuccessDialog(cubit: cubit),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, List<Product>>(
      builder: (context, cart) {
        if (cart.isEmpty) {
          return const CartEmpty();
        }

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.orange.shade50, Colors.white],
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "My Cart",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${cart.length} items",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: cart.length,
                  itemBuilder: (context, i) {
                    final product = cart[i];
                    return CartItemCard(product: product);
                  },
                ),
              ),
              CartSummary(
                cart: cart,
                onBuyNow: () => _showSuccessDialog(context, context.read<CartCubit>()),
              ),
            ],
          ),
        );
      },
    );
  }
}
