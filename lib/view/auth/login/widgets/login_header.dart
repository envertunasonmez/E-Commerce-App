import 'package:flutter/material.dart';
import 'package:basic_e_commerce_app/product/constants/string_constants.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.blue.shade400, Colors.purple.shade400]),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.blue.shade200, blurRadius: 20, offset: const Offset(0, 10)),
            ],
          ),
          child: const Icon(Icons.shopping_bag, size: 40, color: Colors.white),
        ),
        const SizedBox(height: 24),
        Text(
          StringConstants.welcome,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.grey.shade800),
        ),
        const SizedBox(height: 8),
        Text(
          StringConstants.logInToYourAccount,
          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}
