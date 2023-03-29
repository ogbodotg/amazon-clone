import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartSubTotal extends StatelessWidget {
  const CartSubTotal({super.key});

  @override
  Widget build(BuildContext context) {
    Services _services = Services();
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map(((e) => sum += e['quantity'] * e['product']['price'] as int))
        .toList();

    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        children: [
          const Text(
            'Sub Total ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            _services.formatPrice(price: sum, context: context),
            // '$sum ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
