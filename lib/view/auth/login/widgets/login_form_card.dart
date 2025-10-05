import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:basic_e_commerce_app/cubit/auth/login/login_cubit.dart';
import 'package:basic_e_commerce_app/cubit/auth/login/login_state.dart';
import 'package:basic_e_commerce_app/product/constants/string_constants.dart';
import 'package:basic_e_commerce_app/product/utils/validator.dart';
import 'package:basic_e_commerce_app/product/widgets/custom_text_form_field.dart';

class LoginFormCard extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailCtrl;
  final TextEditingController passCtrl;
  final LoginState state;

  const LoginFormCard({
    super.key,
    required this.formKey,
    required this.emailCtrl,
    required this.passCtrl,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 30, offset: const Offset(0, 10)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextFormField(label: StringConstants.email, controller: emailCtrl, validator: Validator.validateEmail),
              const SizedBox(height: 16),
              CustomTextFormField(label: StringConstants.password, controller: passCtrl, isPassword: true, validator: Validator.validatePassword),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: state.isLoading
                    ? Center(child: CircularProgressIndicator(color: Colors.blue.shade600))
                    : ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<LoginCubit>().login(emailCtrl.text, passCtrl.text);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade600,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          shadowColor: Colors.blue.shade200,
                        ),
                        child: Text(
                          StringConstants.logIn,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.5),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
