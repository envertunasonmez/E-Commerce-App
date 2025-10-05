import 'package:flutter/material.dart';
import 'package:basic_e_commerce_app/product/constants/string_constants.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.purple.shade400, Colors.blue.shade400]),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.purple.shade200, blurRadius: 20, offset: const Offset(0, 10)),
            ],
          ),
          child: const Icon(Icons.person_add, size: 40, color: Colors.white),
        ),
        const SizedBox(height: 24),
        Text(
          StringConstants.createAccount,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.grey.shade800),
        ),
        const SizedBox(height: 8),
        Text(
          StringConstants.createANewAccount,
          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}
