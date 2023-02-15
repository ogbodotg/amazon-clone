import 'package:amazon_clone/constants/globals.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CarouselBanner extends StatelessWidget {
  const CarouselBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: Globals.carouselImages.map((e) {
          return Builder(
              builder: (BuildContext context) => Image.network(
                    e,
                    fit: BoxFit.cover,
                    height: 200,
                  ));
        }).toList(),
        options: CarouselOptions(
          viewportFraction: 1,
          height: 200,
        ));
  }
}
