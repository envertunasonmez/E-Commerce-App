import 'package:basic_e_commerce_app/cubit/cart/cart_cubit.dart';
import 'package:basic_e_commerce_app/cubit/category/category_cubit.dart';
import 'package:basic_e_commerce_app/cubit/favorites/favorites_cubit.dart';
import 'package:basic_e_commerce_app/cubit/product/product_cubit.dart';
import 'package:basic_e_commerce_app/data/services/api_service.dart';
import 'package:basic_e_commerce_app/view/cart_view.dart';
import 'package:basic_e_commerce_app/view/favorites_view.dart';
import 'package:basic_e_commerce_app/view/products_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final api = ApiService();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductCubit(api)),
        BlocProvider(create: (_) => FavoritesCubit()),
        BlocProvider(create: (_) => CartCubit()),
        BlocProvider(create: (_) => CategoryCubit(api)..loadCategories()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mini E-Commerce',
        theme: ThemeData.light(),
        home: const MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      // 0: HomePage (kategori listesi)
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

      // 1: Favorites Page
      const FavoritesView(),

      // 2: Cart Page
      const CartView(),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Mini E-Commerce")),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
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
  }
}
