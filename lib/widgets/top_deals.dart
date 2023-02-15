import 'package:flutter/material.dart';

class TopDeals extends StatefulWidget {
  const TopDeals({Key? key}) : super(key: key);

  @override
  State<TopDeals> createState() => _TopDealsState();
}

class _TopDealsState extends State<TopDeals> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10, top: 15),
          child: const Text(
            'Top Deals',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Image.network(
          'https://photos5.appleinsider.com/gallery/46342-93914-Pink-MacBook-Air-xl.jpg',
          height: 235,
          fit: BoxFit.fitHeight,
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
          child: const Text('NGN800000', style: const TextStyle(fontSize: 18)),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
          child: const Text(
            'Apple Mac Air 2025',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                'https://www.notebookcheck.net/fileadmin/Notebooks/News/_nc3/MacBook_Air7035.jpeg',
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
              ),
              Image.network(
                'https://www.zdnet.com/a/img/resize/7c720ec0b3f0f8991bf6d6a6f30913c735e670a1/2020/11/10/52a30c8c-5bc2-4301-820f-6490424f0ee2/apple-macbook-air-with-m1.png?auto=webp&width=1200',
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
              ),
              Image.network(
                'https://photos5.appleinsider.com/gallery/48911-95631-47607-92949-51812357703_d529ba2107_o(1)-xl-xl.jpg',
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
              ),
              Image.network(
                'https://photos5.appleinsider.com/gallery/46342-93914-Pink-MacBook-Air-xl.jpg',
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
              ),
              Image.network(
                'https://www.zdnet.com/a/img/resize/7c720ec0b3f0f8991bf6d6a6f30913c735e670a1/2020/11/10/52a30c8c-5bc2-4301-820f-6490424f0ee2/apple-macbook-air-with-m1.png?auto=webp&width=1200',
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
              ),
              Image.network(
                'https://photos5.appleinsider.com/gallery/48911-95631-47607-92949-51812357703_d529ba2107_o(1)-xl-xl.jpg',
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
              ),
              Image.network(
                'https://photos5.appleinsider.com/gallery/46342-93914-Pink-MacBook-Air-xl.jpg',
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ).copyWith(left: 15),
          alignment: Alignment.topLeft,
          child:
              Text('See all deals', style: const TextStyle(color: Colors.grey)),
        )
      ],
    );
  }
}
