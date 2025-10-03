import 'package:basic_e_commerce_app/cubit/auth/register/register_cubit.dart';
import 'package:basic_e_commerce_app/cubit/auth/register/register_state.dart';
import 'package:basic_e_commerce_app/product/utils/validator.dart';
import 'package:basic_e_commerce_app/view/auth/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:basic_e_commerce_app/product/widgets/custom_text_form_field.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * 0.9;
    final formWidth = maxWidth > 400 ? 400.0 : maxWidth;

    return BlocProvider(
      create: (_) => RegisterCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Register")),
        body: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state.isSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginView()),
              );
            }
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            }
          },
          builder: (context, state) {
            return Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: formWidth),
                  child: Form(
                    key: _formKey,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextFormField(
                              label: "Email",
                              controller: _emailCtrl,
                              validator: Validator.validateEmail,
                            ),
                            const SizedBox(height: 12),
                            CustomTextFormField(
                              label: "Parola",
                              controller: _passCtrl,
                              isPassword: true,
                              validator: Validator.validatePassword,
                            ),
                            const SizedBox(height: 12),
                            CustomTextFormField(
                              label: "Parola (Tekrar)",
                              controller: _confirmCtrl,
                              isPassword: true,
                              validator: (v) =>
                                  Validator.validateConfirmPassword(
                                    v,
                                    _passCtrl.text,
                                  ),
                            ),
                            const SizedBox(height: 18),
                            state.isLoading
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<RegisterCubit>().register(
                                          _emailCtrl.text,
                                          _passCtrl.text,
                                        );
                                      }
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      child: Text("Kayıt Ol"),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
