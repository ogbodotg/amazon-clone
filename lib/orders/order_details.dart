// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/services/services.dart';
import 'package:amazon_clone/widgets/home_top_area.dart';
import 'package:flutter/material.dart';

import 'package:amazon_clone/models/orders.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetailsScreen({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Services.CustomAppBar(),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeTopArea(),

          // CarouselSlider(
          //     items: widget.product.productImages.map((e) {
          //       return Builder(
          //           builder: (BuildContext context) => Image.network(
          //                 e,
          //                 fit: BoxFit.contain,
          //                 height: 350,
          //               ));
          //     }).toList(),
          //     options: CarouselOptions(
          //       viewportFraction: 1,
          //       height: 350,
          //     )),
          const Divider(thickness: 2),
          // Padding(
          //   padding: const EdgeInsets.all(8),
          //   child: RichText(
          //     text: TextSpan(
          //         text: 'Price: ',
          //         style: const TextStyle(
          //           fontWeight: FontWeight.bold,
          //           fontSize: 16,
          //           color: Colors.black,
          //         ),
          //         children: [
          //           TextSpan(
          //             text: _services.formatPrice(
          //                 context: context, price: widget.product.price),
          //             style: const TextStyle(
          //               fontWeight: FontWeight.w500,
          //               fontSize: 16,
          //               color: Colors.redAccent,
          //             ),
          //           )
          //         ]),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(widget.product.productDescription),
          // ),
        ],
      )),
    );
  }
}
