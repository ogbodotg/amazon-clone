// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/services/product_detail_services.dart';
import 'package:amazon_clone/widgets/home_top_area.dart';
import 'package:amazon_clone/widgets/star_ratings.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:amazon_clone/services/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;

  const ProductDetails({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final ProductDetailServices _productDetailServices = ProductDetailServices();
  double averageRating = 0.0;
  double myRating = 0.0;

  @override
  void initState() {
    double totalRating = 0.0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating!;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating!;
      }
    }
    if (totalRating != 0) {
      averageRating = totalRating / widget.product.rating!.length;
    }
    super.initState();
  }

  void addToCart() {
    _productDetailServices.addProductToCart(
        context: context, product: widget.product);
  }

  @override
  Widget build(BuildContext context) {
    Services _services = Services();
    return Scaffold(
      appBar: Services.CustomAppBar(),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomFlatButton(
          label: 'Add to cart',
          onPressed: () {
            // add product to cart
            addToCart();
          },
          color: Colors.green,
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeTopArea(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  widget.product.productName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Stars(rating: averageRating)
              ],
            ),
          ),
          CarouselSlider(
              items: widget.product.productImages.map((e) {
                return Builder(
                    builder: (BuildContext context) => Image.network(
                          e,
                          fit: BoxFit.contain,
                          height: 350,
                        ));
              }).toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                height: 350,
              )),
          const Divider(thickness: 2),
          Padding(
            padding: const EdgeInsets.all(8),
            child: RichText(
              text: TextSpan(
                  text: 'Price: ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: _services.formatPrice(
                          context: context, price: widget.product.price),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.redAccent,
                      ),
                    )
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.product.productDescription),
          ),
          // const Divider(),

          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Rate product',
              style: TextStyle(fontSize: 20),
            ),
          ),
          RatingBar.builder(
              initialRating: myRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
              onRatingUpdate: (rating) {
                _productDetailServices.rateProduct(
                  context: context,
                  product: widget.product,
                  rating: rating,
                );
              })
        ],
      )),
    );
  }
}
