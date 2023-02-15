// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/products/product_details.dart';
import 'package:amazon_clone/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:amazon_clone/services/services.dart';

class CatDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals-screen';
  final String category;
  const CatDealsScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CatDealsScreen> createState() => _CatDealsScreenState();
}

class _CatDealsScreenState extends State<CatDealsScreen> {
  List<Product>? productList;
  final APIServices apiServices = APIServices();
  @override
  void initState() {
    super.initState();

    getProductCategory();
  }

  getProductCategory() async {
    String category = widget.category.replaceAll('&', 'and');

    productList = await apiServices.getCategoryProducts(
      context: context,
      category: category,
    );
    // print('Category is ${widget.category}');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Services.CustomAdminAppBar(
        title: widget.category,
      ),
      body: productList == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text('Checkout more ${widget.category} deals',
                      style: TextStyle(fontSize: 24)),
                ),
                SizedBox(
                  height: 170,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 15),
                    itemCount: productList!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1.4,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: ((context, index) {
                      final product = productList![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, ProductDetails.routeName,
                              arguments: product);
                        },
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                color: Colors.grey.shade100,
                                height: 130,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.network(
                                    product.productImages[0],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.only(
                                left: 5,
                                top: 5,
                              ),
                              child: Text(
                                product.productName,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
    );
  }
}
