import 'package:amazon_clone/search/search_screen.dart';
import 'package:amazon_clone/widgets/address_bar.dart';
import 'package:amazon_clone/widgets/carousel_image.dart';
import 'package:amazon_clone/widgets/home_top_area.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/services/services.dart';
import 'package:amazon_clone/widgets/top_categories.dart';
import 'package:amazon_clone/widgets/top_deals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: Services.CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            HomeTopArea(),
            AddressBar(),
            TopCategories(),
            CarouselBanner(),
            TopDeals()
          ],
        ),
      ),
    );
  }
}
