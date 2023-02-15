import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final IconData? icon;
  final IconData? suffixIcon;
  final String? hintText;
  final bool? obscureText;
  final Function()? onTap;
  final TextInputType keyboardType;
  final int maxLines;
  const TextFieldWidget(
      {Key? key,
      required this.controller,
      this.icon,
      required this.hintText,
      this.obscureText = false,
      this.onTap,
      required this.keyboardType,
      this.maxLines = 1,
      this.suffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText!,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        suffixIcon: onTap == null
            ? null
            : IconButton(
                onPressed: onTap,
                icon: Icon(
                  suffixIcon,
                ),
              ),
        labelStyle: const TextStyle(color: Colors.black),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        enabledBorder: const OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(
              color: Colors.grey,
            )),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(30.0)),
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 2),
        ),
        focusColor: Theme.of(context).primaryColor,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $hintText';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
