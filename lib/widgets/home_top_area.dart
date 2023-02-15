import 'package:amazon_clone/constants/globals.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/search/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class HomeTopArea extends StatefulWidget {
  const HomeTopArea({Key? key}) : super(key: key);

  @override
  State<HomeTopArea> createState() => _HomeTopAreaState();
}

class _HomeTopAreaState extends State<HomeTopArea> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    var selectedItem = '';

    final user = Provider.of<UserProvider>(context).user;
    var customer = user.name.split(' ');
    var customerName = customer[0];
    return Container(
      decoration: const BoxDecoration(
        gradient: Globals.appBarGradient,
      ),
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 55,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: TextFormField(
                    onFieldSubmitted: navigateToSearchScreen,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      hintText: "Hi $customerName!       ...search Amazoon",
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: InkWell(
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child:
                              Icon(Icons.search, size: 20, color: Colors.grey),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                    ),
                    onTap: () {},
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            height: 42,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: const Icon(
              Icons.mic,
              color: Colors.black,
              size: 25,
            ),
          )
        ],
      ),
    );
  }
}
