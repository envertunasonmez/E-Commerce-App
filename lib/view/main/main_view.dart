import 'package:basic_e_commerce_app/view/main/widgets/categories_grid.dart';
import 'package:basic_e_commerce_app/view/main/widgets/main_appbar.dart';
import 'package:basic_e_commerce_app/view/main/widgets/main_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:basic_e_commerce_app/cubit/category/category_cubit.dart';
import 'package:basic_e_commerce_app/cubit/navigation/navigation_cubit.dart';
import 'package:basic_e_commerce_app/view/cart/cart_view.dart';
import 'package:basic_e_commerce_app/view/favorites/favorites_view.dart';


class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      BlocBuilder<CategoryCubit, List<String>>(
        builder: (context, categories) {
          if (categories.isEmpty) {
            return Center(
              child: CircularProgressIndicator(color: Colors.blue.shade600),
            );
          }
          return CategoriesGrid(categories: categories);
        },
      ),
      const FavoritesView(),
      const CartView(),
    ];

    return BlocBuilder<NavigationCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          appBar: const MainAppBar(),
          body: pages[currentIndex],
          bottomNavigationBar: MainBottomNavbar(currentIndex: currentIndex),
        );
      },
    );
  }
}
