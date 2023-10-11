// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/admin/services/backend_services.dart';
import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/services/services.dart';
import 'package:amazon_clone/widgets/home_top_area.dart';
import 'package:flutter/material.dart';

import 'package:amazon_clone/models/orders.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  final AdminServices _adminServices = AdminServices();
  int currentStep = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentStep = widget.order.status;
  }

// admin update order status
  void updateOrderStatus(int status) {
    _adminServices.updateOrderStatus(
        context: context,
        status: status + 1,
        order: widget.order,
        onSuccess: () {
          setState(() {
            currentStep += 1;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    Services _services = Services();
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: Services.CustomAppBar(),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeTopArea(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Order details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Order Date:     ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderTime))}'),
                  SizedBox(height: 5),
                  Text('Order ID:         ${widget.order.id}'),
                  SizedBox(height: 5),
                  Text(
                      'Order ID:         ${_services.formatPrice(price: widget.order.totalPrice, context: context)}'),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Purchase details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < widget.order.products.length; i++)
                    Row(
                      children: [
                        Image.network(
                          widget.order.products[i].productImages[0],
                          height: 120,
                          width: 120,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 5),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.order.products[i].productName,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Quantity: ${widget.order.quantity[i].toString()}',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ))
                      ],
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Tracking',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.black12,
            )),
            child: Stepper(
              currentStep: currentStep,
              controlsBuilder: (context, details) {
                if (user.type == 'admin') {
                  return CustomFlatButton(
                    label: "Done",
                    labelStyle: const TextStyle(fontSize: 20),
                    onPressed: () {
                      // update order status
                      updateOrderStatus(details.currentStep);
                    },
                    borderRadius: 30,
                  );
                }
                return const SizedBox();
              },
              steps: [
                Step(
                  title: Text('Pending'),
                  content: Text(
                      'Your order is still pending, awaiting seller approval'),
                  isActive: currentStep == 0,
                  state:
                      currentStep == 0 ? StepState.complete : StepState.indexed,
                ),
                Step(
                  title: Text('Approved'),
                  content: Text('Seller accepted your order'),
                  isActive: currentStep == 1,
                  state:
                      currentStep > 1 ? StepState.complete : StepState.indexed,
                ),
                Step(
                  title: Text('Delivered'),
                  content: Text('Your order has been delivered.'),
                  isActive: currentStep == 2,
                  state:
                      currentStep > 2 ? StepState.complete : StepState.indexed,
                ),
                Step(
                  title: Text('Verified'),
                  content: Text('You have verified your order'),
                  isActive: currentStep == 3,
                  state:
                      currentStep > 3 ? StepState.complete : StepState.indexed,
                ),
                Step(
                  title: Text('Completed'),
                  content: Text('Your order has been successfully completed'),
                  isActive: currentStep >= 4,
                  state:
                      currentStep > 4 ? StepState.complete : StepState.indexed,
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
