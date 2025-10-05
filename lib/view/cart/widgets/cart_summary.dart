import 'package:basic_e_commerce_app/product/constants/string_constants.dart';
import 'package:basic_e_commerce_app/product/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:basic_e_commerce_app/data/models/product_model.dart';

class CartSummary extends StatelessWidget {
  final List<Product> cart;
  final VoidCallback onBuyNow;
  const CartSummary({super.key, required this.cart, required this.onBuyNow});

  @override
  Widget build(BuildContext context) {
    double subtotal = cart.fold(0, (sum, item) => sum + item.price);
    double shipping = subtotal > 500 ? 0 : 10;
    double total = subtotal + shipping;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, -5),
            blurRadius: 20,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringConstants.subtotal,
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
                ),
                Text(
                  "\$${subtotal.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringConstants.cargo,
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
                ),
                Text(
                  shipping == 0
                      ? StringConstants.free
                      : "\$${shipping.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: shipping == 0
                        ? Colors.green.shade600
                        : Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            if (shipping > 0) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.local_shipping_outlined,
                      size: 20,
                      color: Colors.orange.shade600,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "\$${(500 - subtotal).toStringAsFixed(2)} more to get free shipping!",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.orange.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey.shade200,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringConstants.total,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                Text(
                  "\$${total.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              text: StringConstants.buyNow,
              backgroundColor: Colors.orange.shade600,
              height: 56,
              width: double.infinity,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              borderRadius: 16,
              icon: const Icon(Icons.payment_rounded, size: 22),
              onPressed: onBuyNow,
            ),
          ],
        ),
      ),
    );
  }
}
