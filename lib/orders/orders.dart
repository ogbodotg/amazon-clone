import 'package:amazon_clone/constants/globals.dart';
import 'package:amazon_clone/products/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List list = [
    'https://images.unsplash.com/photo-1514342959091-2bffd8a7c4ba?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    'https://images.unsplash.com/photo-1514342959091-2bffd8a7c4ba?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    'https://images.unsplash.com/photo-1514342959091-2bffd8a7c4ba?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    'https://images.unsplash.com/photo-1514342959091-2bffd8a7c4ba?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
            itemCount: list.length,
            itemBuilder: (((context, index) {
              return ProductWidget(
                image: list[index],
              );
            }))),
      )
    ]);
  }
}
