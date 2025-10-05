import 'package:flutter/material.dart';
import 'package:basic_e_commerce_app/product/constants/string_constants.dart';
import 'package:basic_e_commerce_app/view/auth/login/login_view.dart';

class LoginLink extends StatelessWidget {
  const LoginLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          StringConstants.alreadyHaveAnAccount,
          style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
        ),
        TextButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => LoginView()),
          ),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          child: Text(
            StringConstants.logIn,
            style: TextStyle(
              color: Colors.purple.shade600,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
