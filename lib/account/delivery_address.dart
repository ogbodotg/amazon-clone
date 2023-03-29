// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import 'package:amazon_clone/common/widgets/common_services.dart';
import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/text-field.dart';
import 'package:amazon_clone/constants/utilities.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/services/api_services.dart';
import 'package:amazon_clone/services/services.dart';
import 'package:amazon_clone/widgets/address_bar.dart';

class AddressPage extends StatefulWidget {
  static const String routeName = '/address-screen';
  const AddressPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final _addressKey = GlobalKey<FormState>();
  final APIServices _apiServices = APIServices();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _townController = TextEditingController();

  String _address = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void makePayment(String addressOnFile) {
    _address = '';
    bool formNotEmpty = _phoneController.text.isNotEmpty ||
        _streetController.text.isNotEmpty ||
        _townController.text.isNotEmpty;

    if (formNotEmpty) {
      if (_addressKey.currentState!.validate()) {
        _address =
            '${_phoneController.text} - ${_streetController.text},${_townController.text} ';
      } else {
        throw Exception('Please complete delivery form fields');
      }
    } else if (addressOnFile.isNotEmpty) {
      _address = addressOnFile;
    } else {
      showSnackBar(context, 'An error occured');
    }

    print('Address $_address');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _townController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CommonServices _commonServices = CommonServices();
    var addressFromProvider = context.watch<UserProvider>().user.address;
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map(((e) => sum += e['quantity'] * e['product']['price'] as int))
        .toList();

    return Scaffold(
      appBar: Services.CustomAdminAppBar(
        title: 'Set delivery Address',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (addressFromProvider.isNotEmpty) AddressBar(),
            _commonServices.sizedBox(h: 15),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'To deliver to a different address from what we have on file, please complete delivery details below: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ),
            _commonServices.sizedBox(h: 8),
            Form(
              key: _addressKey,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  TextFieldWidget(
                    controller: _phoneController,
                    icon: Icons.phone_android,
                    hintText: "Phone Number",
                    obscureText: false,
                    keyboardType: TextInputType.phone,
                    onTap: null,
                  ),
                  _commonServices.sizedBox(h: 8),
                  TextFieldWidget(
                    controller: _streetController,
                    icon: Icons.location_history,
                    hintText: "Street Address",
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    onTap: null,
                  ),
                  _commonServices.sizedBox(h: 8),
                  TextFieldWidget(
                    controller: _townController,
                    icon: Icons.location_city,
                    hintText: "Town/State/Country",
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    onTap: null,
                  ),
                  _commonServices.sizedBox(h: 10),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Select Payment Method',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        // PAYSTACK PAYMENT GATEWAY
                        GestureDetector(
                          onTap: () {
                            makePayment(addressFromProvider);

                            if (addressFromProvider.isEmpty) {
                              // save new address to database
                              _apiServices.saveDeliveryAddress(
                                  context: context, address: _address);
                            }
                            _apiServices.placeOrder(
                              context: context,
                              address: _address,
                              totalPrice: sum,
                            );
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                height: 65,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      // color: Theme.of(context).primaryColor,
                                      ),
                                ),
                                child: Center(
                                    child: Image.asset(
                                  "assets/images/paystack.jpeg",
                                  fit: BoxFit.cover,
                                  width: 280,
                                  height: 80,
                                )),
                              )),
                        ),

                        // flutter wave payment
                        GestureDetector(
                          onTap: () {
                            // flutterwave payment
                            makePayment(addressFromProvider);

                            if (addressFromProvider.isEmpty) {
                              // save new address to database
                              _apiServices.saveDeliveryAddress(
                                  context: context, address: _address);
                            }
                            _apiServices.placeOrder(
                                context: context,
                                address: _address,
                                totalPrice: sum);
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                height: 65,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      // color: Theme.of(context).primaryColor,
                                      ),
                                ),
                                child: Center(
                                    child: Image.asset(
                                  "assets/images/flutterwave.jpeg",
                                  fit: BoxFit.cover,
                                  width: 280,
                                  height: 80,
                                )),
                              )),
                        ),
                      ],
                    ),
                  ),
                  // CustomFlatButton(
                  //   label: "Update Address",
                  //   labelStyle: const TextStyle(fontSize: 20),
                  //   onPressed: () {},
                  //   borderRadius: 30,
                  // ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
