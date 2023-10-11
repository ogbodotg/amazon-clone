import 'package:amazon_clone/admin/services/backend_services.dart';
import 'package:amazon_clone/models/orders.dart';
import 'package:amazon_clone/orders/order_details.dart';
import 'package:amazon_clone/products/product.dart';
import 'package:amazon_clone/services/services.dart';
import 'package:flutter/material.dart';

class AdminOrderScreen extends StatefulWidget {
  const AdminOrderScreen({super.key});

  @override
  State<AdminOrderScreen> createState() => _AdminOrderScreenState();
}

class _AdminOrderScreenState extends State<AdminOrderScreen> {
  final AdminServices _adminServices = AdminServices();
  List<Order>? orders;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await _adminServices.getAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: Services.CustomAdminAppBar(title: 'Orders'),
            body: GridView.builder(
              itemCount: orders!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final orderData = orders![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      OrderDetailsScreen.routeName,
                      arguments: orderData,
                    );
                  },
                  child: SizedBox(
                    height: 140,
                    child: ProductWidget(
                        image: orderData.products[0].productImages[0]),
                  ),
                );
              },
            ),
          );
  }
}
