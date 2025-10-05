import 'package:flutter/material.dart';
import 'package:basic_e_commerce_app/view/main/widgets/categories_header.dart';
import 'package:basic_e_commerce_app/view/main/widgets/category_card.dart';

class CategoriesGrid extends StatelessWidget {
  final List<String> categories;
  const CategoriesGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
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
          const SliverToBoxAdapter(child: CategoriesHeader()),
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
                return CategoryCard(category: category, index: index);
              }, childCount: categories.length),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
