import 'package:basic_e_commerce_app/cubit/cart/cart_cubit.dart';
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

        // Ekran boyutuna göre sütun sayısını ayarla
        final width = MediaQuery.of(context).size.width;
        int crossAxisCount = 2;
        if (width > 1200) {
          crossAxisCount = 4;
        } else if (width > 800) {
          crossAxisCount = 3;
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.7,
          ),
          itemCount: favorites.length,
          itemBuilder: (context, i) {
            final product = favorites[i];
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Ürün görseli
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.network(
                            product.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Başlık
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Fiyat
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "\$${product.price}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Sepete ekle butonu
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<CartCubit>().addToCart(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "${product.title} sepete eklendi",
                                ),
                                duration: const Duration(milliseconds: 800),
                              ),
                            );
                          },
                          child: const Text("Sepete Ekle"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            minimumSize: const Size.fromHeight(36),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                  // Çöp kutusu ikonu (favorilerden çıkar)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        context.read<FavoritesCubit>().toggleFavorite(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${product.title} favorilerden çıkarıldı",
                            ),
                            duration: const Duration(milliseconds: 800),
                          ),
                        );
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.white70,
                        child: Icon(Icons.delete, color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
