import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:basic_e_commerce_app/cubit/navigation/navigation_cubit.dart';

class MainBottomNavbar extends StatelessWidget {
  final int currentIndex;
  const MainBottomNavbar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final navbarColors = [
      Colors.blue.shade600,
      Colors.pink.shade400,
      Colors.orange.shade600,
    ];

    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => context.read<NavigationCubit>().setIndex(i),
        selectedItemColor: navbarColors[currentIndex],
        unselectedItemColor: Colors.grey.shade400,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_rounded),
            label: "Cart",
          ),
        ],
      ),
    );
  }
}
