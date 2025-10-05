import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:basic_e_commerce_app/cubit/favorites/favorites_cubit.dart';
import 'package:basic_e_commerce_app/data/models/product_model.dart';

class ProductFavoriteButton extends StatelessWidget {
  final Product product;
  final bool isFavorite;
  const ProductFavoriteButton({
    super.key,
    required this.product,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<FavoritesCubit>().toggleFavorite(product);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isFavorite
                  ? "${product.title} removed from favorites"
                  : "${product.title} added to favorites",
            ),
            duration: const Duration(milliseconds: 800),
            backgroundColor:
                isFavorite ? Colors.grey.shade700 : Colors.red.shade400,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) =>
              ScaleTransition(scale: animation, child: child),
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            key: ValueKey(isFavorite),
            color: isFavorite ? Colors.red : Colors.grey.shade400,
            size: 20,
          ),
        ),
      ),
    );
  }
}
