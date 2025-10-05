import 'package:basic_e_commerce_app/product/constants/assets_constants.dart';
import 'package:basic_e_commerce_app/product/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CategoriesHeader extends StatelessWidget {
  const CategoriesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            AssetsConstants.shoppingCartAnimation,
            width: 140,
            height: 140,
            fit: BoxFit.cover,
          ),
          Text(
            StringConstants.categories,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            StringConstants.startShoppingBySelectingACategory,
            style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
