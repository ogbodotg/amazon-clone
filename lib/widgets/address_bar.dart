import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class AddressBar extends StatelessWidget {
  const AddressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
      ),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                'Delivery to ${user.address}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 5, top: 2),
            child: Icon(Icons.arrow_drop_down_outlined, size: 18),
          )
        ],
      ),
    );
  }
}
