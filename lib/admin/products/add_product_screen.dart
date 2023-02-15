import 'dart:io';

import 'package:amazon_clone/admin/product_screen.dart';
import 'package:amazon_clone/admin/services/backend_services.dart';
import 'package:amazon_clone/common/widgets/common_services.dart';
import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/text-field.dart';
import 'package:amazon_clone/constants/utilities.dart';
import 'package:amazon_clone/services/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddProduct extends StatefulWidget {
  static const String routeName = '/add-product-screen';

  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final AdminServices _adminServices = AdminServices();

  String category = 'Phones and Accessories';
  List<File> images = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = [
    'Phones and Accessories',
    'Fashion',
    'Books',
    'Electronics',
    'Computers',
  ];

  void publishProduct() {
    if (_formKey.currentState!.validate() && images.isNotEmpty) {
      _adminServices.publishProduct(
          context: context,
          productName: productNameController.text,
          productDescription: descriptionController.text,
          price: int.parse(priceController.text),
          quantity: int.parse(quantityController.text),
          category: category,
          productImages: images,
          onSuccess: () {
            showSnackBar(context, 'Product added successfully');
            // Navigator.pop(context);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Products()));
            });
            // setState(() {});
          });
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    CommonServices _commonServices = CommonServices();
    return Scaffold(
      appBar: Services.CustomAdminAppBar(title: 'Add Product'),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _commonServices.sizedBox(
                    h: 20,
                  ),
                  images.isNotEmpty
                      ? CarouselSlider(
                          items: images.map((e) {
                            return Builder(
                                builder: (BuildContext context) => Image.file(
                                      e,
                                      fit: BoxFit.cover,
                                      height: 200,
                                    ));
                          }).toList(),
                          options: CarouselOptions(
                            viewportFraction: 1,
                            height: 200,
                          ))
                      : GestureDetector(
                          onTap: selectImages,
                          child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(10),
                              dashPattern: [10, 4],
                              strokeCap: StrokeCap.round,
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.folder_open, size: 40),
                                    _commonServices.sizedBox(
                                      h: 15,
                                    ),
                                    const Text('Select Images',
                                        style: TextStyle(color: Colors.grey))
                                  ],
                                ),
                              )),
                        ),
                  _commonServices.sizedBox(
                    h: 15,
                  ),
                  TextFieldWidget(
                    controller: productNameController,
                    icon: null,
                    hintText: 'Product Name',
                    obscureText: false,
                    onTap: null,
                    keyboardType: TextInputType.text,
                  ),
                  _commonServices.sizedBox(
                    h: 15,
                  ),
                  TextFieldWidget(
                    controller: descriptionController,
                    icon: null,
                    hintText: 'Description',
                    obscureText: false,
                    onTap: null,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                  ),
                  _commonServices.sizedBox(
                    h: 15,
                  ),
                  TextFieldWidget(
                    controller: priceController,
                    hintText: 'Price',
                    keyboardType: TextInputType.number,
                  ),
                  _commonServices.sizedBox(
                    h: 15,
                  ),
                  TextFieldWidget(
                    controller: quantityController,
                    hintText: 'Quantity',
                    keyboardType: TextInputType.number,
                  ),
                  _commonServices.sizedBox(
                    h: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      value: category,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: productCategories.map((String e) {
                        return DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          category = newValue!;
                        });
                      },
                    ),
                  ),
                  _commonServices.sizedBox(
                    h: 15,
                  ),
                  CustomFlatButton(
                    label: 'Publish',
                    labelStyle: const TextStyle(fontSize: 16),
                    onPressed: () {
                      publishProduct();
                    },
                    color: Theme.of(context).primaryColor,
                    borderRadius: 30,
                  )
                ],
              ),
            )),
      ),
    );
  }
}
