import 'package:basic_e_commerce_app/view/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:basic_e_commerce_app/cubit/cart/cart_cubit.dart';
import 'package:basic_e_commerce_app/cubit/category/category_cubit.dart';
import 'package:basic_e_commerce_app/cubit/favorites/favorites_cubit.dart';
import 'package:basic_e_commerce_app/cubit/product/product_cubit.dart';
import 'package:basic_e_commerce_app/data/services/api_service.dart';

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
        home: const MainView(),
      ),
    );
  }
}
