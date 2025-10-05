import 'package:basic_e_commerce_app/product/constants/string_constants.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        StringConstants.miniECommerce,
        style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.grey.shade800,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
