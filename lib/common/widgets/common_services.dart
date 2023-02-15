import 'package:flutter/material.dart';

class CommonServices {
  //appwide sizedbox
  Widget sizedBox({double? h, double? w}) {
    return SizedBox(
      height: h ?? 0,
      width: w ?? 0,
    );
  }
}
