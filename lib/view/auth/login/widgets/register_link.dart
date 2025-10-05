import 'package:flutter/material.dart';
import 'package:basic_e_commerce_app/product/constants/string_constants.dart';
import 'package:basic_e_commerce_app/view/auth/register/register_view.dart';

class RegisterLink extends StatelessWidget {
  const RegisterLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(StringConstants.dontHaveAnAccount, style: TextStyle(color: Colors.grey.shade700, fontSize: 15)),
        TextButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterView())),
          style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8)),
          child: Text(StringConstants.register, style: TextStyle(color: Colors.blue.shade600, fontSize: 15, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
