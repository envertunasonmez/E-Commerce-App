import 'package:basic_e_commerce_app/cubit/cart/cart_cubit.dart';
import 'package:basic_e_commerce_app/cubit/favorites/favorites_cubit.dart';
import 'package:basic_e_commerce_app/cubit/product/product_cubit.dart';
import 'package:basic_e_commerce_app/cubit/product/product_state.dart';
import 'package:basic_e_commerce_app/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductView extends StatelessWidget {
  final String category;
  const ProductView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category.toUpperCase())),
      body: BlocBuilder<ProductCubit, ProductState?>(
        builder: (context, state) {
          if (state == null || state.category != category) {
            context.read<ProductCubit>().loadProducts(category);
            return const Center(child: CircularProgressIndicator());
          }

          final products = state.products;
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: products.length,
            itemBuilder: (context, i) => ProductCard(product: products[i]),
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Ürün görseli
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.network(product.image, fit: BoxFit.cover),
            ),
          ),
          // Başlık ve fiyat
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "\$${product.price}",
              style: const TextStyle(fontSize: 14, color: Colors.green),
            ),
          ),
          const SizedBox(height: 4),
          // Butonlar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.red),
                onPressed: () {
                  context.read<FavoritesCubit>().toggleFavorite(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${product.title} favorilere eklendi"),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.add_shopping_cart, color: Colors.blue),
                onPressed: () {
                  context.read<CartCubit>().addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${product.title} sepete eklendi")),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
