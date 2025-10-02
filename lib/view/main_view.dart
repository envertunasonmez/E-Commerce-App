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
      // Categories Grid
      BlocBuilder<CategoryCubit, List<String>>(
        builder: (context, categories) {
          if (categories.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final size = MediaQuery.of(context).size;
          final crossAxisCount = size.width > 600 ? 3 : 2; // Tablet vs. phone
          final childAspectRatio = size.width > 600 ? 3 / 4 : 2 / 3;

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: childAspectRatio,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductView(category: category),
                    ),
                  );
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Responsive container boyutu
                      Container(
                        height: size.width * 0.25, // ekran genişliğine göre
                        width: size.width * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade200,
                        ),
                        child: Center(
                          child: Text(
                            category[0].toUpperCase(),
                            style: TextStyle(
                              fontSize: size.width * 0.08, // responsive font
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // Örn: Image.asset("assets/${category}.png")
                      ),
                      SizedBox(height: size.height * 0.01),
                      Text(
                        category.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
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
