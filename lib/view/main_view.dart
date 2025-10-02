import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:basic_e_commerce_app/cubit/category/category_cubit.dart';
import 'package:basic_e_commerce_app/cubit/navigation/navigation_cubit.dart';
import 'package:basic_e_commerce_app/view/cart_view.dart';
import 'package:basic_e_commerce_app/view/favorites_view.dart';
import 'package:basic_e_commerce_app/view/products_view.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      BlocBuilder<CategoryCubit, List<String>>(
        builder: (context, categories) {
          if (categories.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, i) {
              return ListTile(
                title: Text(categories[i]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductView(category: categories[i]),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      const FavoritesView(),
      const CartView(),
    ];

    return BlocBuilder<NavigationCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          appBar: AppBar(title: const Text("Mini E-Commerce")),
          body: pages[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (i) => context.read<NavigationCubit>().setIndex(i),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "Favorites",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: "Cart",
              ),
            ],
          ),
        );
      },
    );
  }
}
