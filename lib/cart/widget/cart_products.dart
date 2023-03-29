// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/services/product_detail_services.dart';
import 'package:amazon_clone/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;

  const CartProduct({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailServices _productDetailServices = ProductDetailServices();

  void increaseCartQty(Product product) {
    _productDetailServices.addProductToCart(context: context, product: product);
  }

  void decreaseCartQty(Product product) {
    _productDetailServices.removeProductToCart(
        context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    Services _services = Services();
    final cartProduct = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(cartProduct['product']);
    final quantity = cartProduct['quantity'];

    return Column(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 135,
                    width: 100,
                    color: Colors.white,
                    child: Image.network(
                      product.productImages[0],
                      fit: BoxFit.contain,
                      height: 125,
                      width: 115,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: 235,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        product.productName,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        product.productDescription,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        maxLines: 3,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        _services.formatPrice(
                            price: product.price, context: context),
                        // 'NGN${product.price}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                )
              ],
            )),
        // cart quantity
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        decreaseCartQty(product);
                      },
                      child: Container(
                          width: 30,
                          height: 25,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.remove,
                            size: 18,
                          )),
                    ),
                    Container(
                        width: 30,
                        height: 25,
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Text(quantity.toString())),
                    InkWell(
                      onTap: () {
                        increaseCartQty(product);
                      },
                      child: Container(
                          width: 30,
                          height: 25,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.add,
                            size: 18,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
