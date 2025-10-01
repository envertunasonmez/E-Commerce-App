import 'package:basic_e_commerce_app/cubit/favorites/favorites_cubit.dart';
import 'package:basic_e_commerce_app/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, List<Product>>(
      builder: (context, favorites) {
        if (favorites.isEmpty) {
          return const Center(child: Text("Henüz favoriniz yok"));
        }

        return ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, i) {
            final product = favorites[i];
            return ListTile(
              leading: Image.network(product.image, width: 50),
              title: Text(product.title),
              subtitle: Text("\$${product.price}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  context.read<FavoritesCubit>().toggleFavorite(product);
                },
              ),
            );
          },
        );
      },
    );
  }
}
