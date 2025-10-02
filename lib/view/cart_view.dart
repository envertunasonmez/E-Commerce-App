import 'package:basic_e_commerce_app/cubit/cart/cart_cubit.dart';
import 'package:basic_e_commerce_app/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, List<Product>>(
      builder: (context, cart) {
        if (cart.isEmpty) {
          return const Center(child: Text("Sepetiniz boş"));
        }

        double subtotal = cart.fold(0, (sum, item) => sum + item.price);
        double shipping = subtotal > 500 ? 0 : 10; // Artık 500$ üstü ücretsiz
        double total = subtotal + shipping;

        return Column(
          children: [
            // Ürün listesi
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: cart.length,
                itemBuilder: (context, i) {
                  final product = cart[i];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: Image.network(
                        product.image,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(product.title),
                      subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.remove_circle,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          context.read<CartCubit>().removeFromCart(product);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            // Sepet özeti ve satın al
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, -2),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Ara toplam
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Ara Toplam:", style: TextStyle(fontSize: 16)),
                      Text(
                        "\$${subtotal.toStringAsFixed(2)}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Kargo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Kargo:", style: TextStyle(fontSize: 16)),
                      Text(
                        shipping == 0
                            ? "Ücretsiz"
                            : "\$${shipping.toStringAsFixed(2)}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const Divider(height: 16, thickness: 1),
                  // Toplam
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Toplam:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\$${total.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Satın Al Butonu
                  ElevatedButton.icon(
                    icon: const Icon(Icons.payment),
                    label: const Text("Satın Al"),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Satın alma işlemi başarıyla tamamlandı!",
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
