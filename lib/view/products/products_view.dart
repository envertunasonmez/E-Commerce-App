import 'package:basic_e_commerce_app/cubit/product/product_cubit.dart';
import 'package:basic_e_commerce_app/cubit/product/product_state.dart';
import 'package:basic_e_commerce_app/view/products/widgets/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductView extends StatelessWidget {
  final String category;
  const ProductView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          category.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey.shade800,
      ),
      body: BlocBuilder<ProductCubit, ProductState?>(
        builder: (context, state) {
          if (state == null || state.category != category) {
            context.read<ProductCubit>().loadProducts(category);
            return Center(
              child: CircularProgressIndicator(color: Colors.blue.shade600),
            );
          }
          return ProductGrid(products: state.products);
        },
      ),
    );
  }
}
