import 'package:basic_e_commerce_app/view/products/widgets/product_add_to_cart_button.dart';
import 'package:basic_e_commerce_app/view/products/widgets/product_favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:basic_e_commerce_app/cubit/favorites/favorites_cubit.dart';
import 'package:basic_e_commerce_app/data/models/product_model.dart';
import 'package:basic_e_commerce_app/product/widgets/custom_cached_network_image.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.watch<FavoritesCubit>().isFavorite(product);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CustomCachedImage(
                  imageUrl: product.image,
                  fit: BoxFit.cover,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: ProductFavoriteButton(
                    product: product,
                    isFavorite: isFavorite,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "\$${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                ProductAddToCartButton(product: product),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
