import 'package:amazon_clone/constants/globals.dart';
import 'package:amazon_clone/widgets/top_area.dart';
import 'package:amazon_clone/orders/orders.dart';
import 'package:amazon_clone/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Services.CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopArea(),
            Services.sizedBox(h: 10),
            Orders(),
          ],
        ),
      ),
    );
  }
}
