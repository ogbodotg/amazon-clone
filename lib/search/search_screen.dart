// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/products/product_details.dart';
import 'package:amazon_clone/services/search_services.dart';
import 'package:amazon_clone/services/services.dart';
import 'package:amazon_clone/widgets/home_top_area.dart';
import 'package:amazon_clone/widgets/searched_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({
    Key? key,
    required this.searchQuery,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();

  @override
  void initState() {
    getSearchedProduct();
    super.initState();
  }

  getSearchedProduct() async {
    products = await searchServices.getSearchedProducts(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Services.CustomAppBar(),
      body: products == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                const HomeTopArea(),
                Services.sizedBox(h: 10),
                Expanded(
                    child: ListView.builder(
                        itemCount: products!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ProductDetails.routeName,
                                    arguments: products![index]);
                              },
                              child:
                                  SearchedProduct(product: products![index]));
                        })),
              ],
            ),
    );
  }
}
