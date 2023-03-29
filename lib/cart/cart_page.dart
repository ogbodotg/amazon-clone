import 'package:amazon_clone/account/delivery_address.dart';
import 'package:amazon_clone/cart/widget/cart_products.dart';
import 'package:amazon_clone/cart/widget/cart_sub_total.dart';
import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/services/services.dart';
import 'package:amazon_clone/widgets/address_bar.dart';
import 'package:amazon_clone/widgets/home_top_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void navigateToAddressPage() {
    Navigator.pushNamed(context, AddressPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return Scaffold(
      appBar: Services.CustomAppBar(),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(12),
        child: CustomFlatButton(
          label:
              'Check Out (${user.cart.length} ${user.cart.length > 1 ? 'items' : 'item'} )',
          onPressed: () {
            // place order
            navigateToAddressPage();
          },
          color: Colors.green,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HomeTopArea(),
            const AddressBar(),
            const CartSubTotal(),

            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            ListView.builder(
                itemCount: user.cart.length,
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return CartProduct(
                    index: index,
                  );
                }))
          ],
        ),
      ),
    );
  }
}
