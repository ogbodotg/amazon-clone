import 'package:amazon_clone/constants/globals.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class TopArea extends StatefulWidget {
  const TopArea({Key? key}) : super(key: key);

  @override
  State<TopArea> createState() => _TopAreaState();
}

class _TopAreaState extends State<TopArea> {
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
                text: 'Hello ',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: customerName,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: "OpenSans",
                    ),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
