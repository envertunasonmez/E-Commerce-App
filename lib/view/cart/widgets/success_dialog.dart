import 'package:basic_e_commerce_app/product/constants/assets_constants.dart';
import 'package:basic_e_commerce_app/product/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:basic_e_commerce_app/cubit/cart/cart_cubit.dart';

class SuccessDialog extends StatelessWidget {
  final CartCubit cubit;
  const SuccessDialog({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Lottie.asset(
                AssetsConstants.buySuccessAnimation,
                repeat: false,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Purchase Successful!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Thank you for your purchase. Your order is being processed.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),
            CustomElevatedButton(
              text: "Continue Shopping",
              backgroundColor: Colors.green.shade500,
              height: 48,
              width: double.infinity,
              fontSize: 16,
              borderRadius: 16,
              onPressed: () {
                Navigator.of(context).pop();
                cubit.clearCart();
              },
            ),
          ],
        ),
      ),
    );
  }
}
