import 'package:basic_e_commerce_app/product/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:basic_e_commerce_app/cubit/cart/cart_cubit.dart';
import 'package:basic_e_commerce_app/data/models/product_model.dart';
import 'package:basic_e_commerce_app/product/widgets/custom_elevated_button.dart';

class ProductAddToCartButton extends StatelessWidget {
  final Product product;
  const ProductAddToCartButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      text: StringConstants.addToCart,
      backgroundColor: Colors.blue.shade600,
      height: 36,
      width: double.infinity,
      onPressed: () {
        context.read<CartCubit>().addToCart(product);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${product.title} added to cart"),
            duration: const Duration(milliseconds: 800),
            backgroundColor: Colors.green.shade400,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
    );
  }
}
