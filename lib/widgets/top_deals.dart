import 'package:amazon_clone/admin/product_screen.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/products/product_details.dart';
import 'package:amazon_clone/services/api_services.dart';
import 'package:amazon_clone/services/services.dart';
import 'package:flutter/material.dart';

class TopDeals extends StatefulWidget {
  const TopDeals({Key? key}) : super(key: key);

  @override
  State<TopDeals> createState() => _TopDealsState();
}

class _TopDealsState extends State<TopDeals> {
  Product? product;
  final APIServices _apiServices = APIServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDealOfTheDay();
  }

  void getDealOfTheDay() async {
    product = await _apiServices.getDealOfTheDay(context: context);
    setState(() {});
  }

  void navigateToProductDetails() {
    Navigator.pushNamed(context, ProductDetails.routeName, arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    Services _services = Services();
    return product == null
        ? Center(child: CircularProgressIndicator())
        : product!.productName.isEmpty
            ? SizedBox()
            : GestureDetector(
                onTap: navigateToProductDetails,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 10, top: 15, bottom: 5),
                      child: const Text(
                        'Top Deals',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Image.network(
                      product!.productImages[0],
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 15, top: 5, right: 40),
                      child: Text(
                          _services.formatPrice(
                              context: context, price: product!.price),
                          style: const TextStyle(fontSize: 18)),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 15, top: 5, right: 40),
                      child: Text(product!.productName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          )),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: product!.productImages
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      color: Colors.grey.shade200,
                                      height: 120,
                                      width: 110,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.network(
                                          e.toString(),
                                          fit: BoxFit.contain,
                                          width: 80,
                                          height: 90,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList()),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ).copyWith(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text('See all deals',
                          style: const TextStyle(color: Colors.grey)),
                    )
                  ],
                ),
              );
  }
}
