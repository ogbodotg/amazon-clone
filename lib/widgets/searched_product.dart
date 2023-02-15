// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/widgets/star_ratings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:amazon_clone/models/product_model.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Image.network(
                  product.productImages[0],
                  fit: BoxFit.contain,
                  height: 135,
                  width: 135,
                ),
                Column(
                  children: [
                    Container(
                      width: 235,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        product.productName,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        product.productDescription,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        maxLines: 3,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: const Stars(rating: 5),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        'NGN${product.price}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                )
              ],
            ))
      ],
    );
  }
}
