import 'package:basic_e_commerce_app/cubit/password_visibility/password_visibility_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    if (isPassword) {
      return BlocProvider(
        create: (_) => PasswordVisibilityCubit(),
        child: BlocBuilder<PasswordVisibilityCubit, bool>(
          builder: (context, isHidden) {
            return _buildTextField(context, isHidden);
          },
        ),
      );
    } else {
      return _buildTextField(context, false);
    }
  }

  Widget _buildTextField(BuildContext context, bool obscureText) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      keyboardType: label.toLowerCase().contains("email")
          ? TextInputType.emailAddress
          : TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey[600],
                ),
                onPressed: () {
                  context.read<PasswordVisibilityCubit>().toggle();
                },
              )
            : null,
      ),
    );
  }
}
