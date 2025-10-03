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
            return Center(
              child: CircularProgressIndicator(color: Colors.blue.shade600),
            );
          }

          final size = MediaQuery.of(context).size;
          int crossAxisCount = 2;
          if (size.width > 1200) {
            crossAxisCount = 4;
          } else if (size.width > 600) {
            crossAxisCount = 3;
          }

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.shade50, Colors.white],
              ),
            ),
            child: CustomScrollView(
              slivers: [
                // Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kategoriler",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Alışverişe başlamak için bir kategori seçin",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Categories Grid
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final category = categories[index];
                      final colors = [
                        [Colors.blue.shade400, Colors.blue.shade600],
                        [Colors.purple.shade400, Colors.purple.shade600],
                        [Colors.orange.shade400, Colors.orange.shade600],
                        [Colors.teal.shade400, Colors.teal.shade600],
                      ];
                      final colorPair = colors[index % colors.length];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductView(category: category),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: colorPair,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: colorPair[0].withOpacity(0.4),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ProductView(category: category),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.3),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          category[0].toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 36,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      category.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }, childCount: categories.length),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            ),
          );
        },
      ),
      const FavoritesView(),
      const CartView(),
    ];

    return BlocBuilder<NavigationCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Mini E-Commerce",
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.grey.shade800,
          ),
          body: pages[currentIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (i) => context.read<NavigationCubit>().setIndex(i),
              selectedItemColor: Colors.blue.shade600,
              unselectedItemColor: Colors.grey.shade400,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: "Ana Sayfa",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_rounded),
                  label: "Favoriler",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_rounded),
                  label: "Sepet",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
