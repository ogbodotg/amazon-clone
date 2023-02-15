import 'package:amazon_clone/constants/globals.dart';
import 'package:amazon_clone/pages/cat_deals_screen.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({Key? key}) : super(key: key);

  void navigateToCatScreen(BuildContext context, String category) {
    Navigator.pushNamed(context, CatDealsScreen.routeName, arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      color: Colors.grey.shade100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemExtent: 75,
          itemCount: Globals.carouselImages.length,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () {
                navigateToCatScreen(
                    context, Globals.categoryImages[index]['title']!);
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            Globals.categoryImages[index]['image']!,
                            fit: BoxFit.cover,
                            height: 45,
                            width: 45,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    Globals.categoryImages[index]['title']!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            );
          })),
    );
  }
}
