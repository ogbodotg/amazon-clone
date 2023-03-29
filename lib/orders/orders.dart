import 'package:amazon_clone/constants/globals.dart';
import 'package:amazon_clone/models/orders.dart';
import 'package:amazon_clone/orders/order_details.dart';
import 'package:amazon_clone/products/product.dart';
import 'package:amazon_clone/services/account_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final AccountServices _accountServices = AccountServices();
  List<Order>? orders;

  @override
  void initState() {
    super.initState();
    getUserOrders();
  }

  void getUserOrders() async {
    orders = await _accountServices.getUserOrders(
      context: context,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: orders == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text(
                        'Your Orders',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Container(
                      padding: const EdgeInsets.only(right: 15),
                      child: Text(
                        'See All',
                        style: TextStyle(color: Globals.selectedNavBarColor),
                      )),
                ],
              ),

              // display customer orders
              Container(
                height: 170,
                padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: orders!.length,
                    itemBuilder: (((context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, OrderDetailsScreen.routeName,
                              arguments: orders![index]);
                        },
                        child: ProductWidget(
                          image: orders![index].products[0].productImages[0],
                        ),
                      );
                    }))),
              )
            ]),
    );
  }
}
