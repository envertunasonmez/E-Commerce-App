import 'package:basic_e_commerce_app/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:basic_e_commerce_app/cubit/favorites/favorites_cubit.dart';
import 'widgets/favorites_empty.dart';
import 'widgets/favorite_item_card.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, List<Product>>(
      builder: (context, favorites) {
        if (favorites.isEmpty) {
          return const FavoritesEmpty();
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.65,
          ),
          itemCount: favorites.length,
          itemBuilder: (context, i) {
            final product = favorites[i];
            return FavoriteItemCard(product: product);
          },
        );
      },
    );
  }
}
