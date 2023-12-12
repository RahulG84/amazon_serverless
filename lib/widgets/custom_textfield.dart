import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController? controller;
  String? hintText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  bool secureText;
  Key? textFormFieldKey;
  int maxLine;
  CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.secureText = false,
    this.textFormFieldKey,
    this.maxLine = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Key textFormFieldKey = GlobalKey<FormState>();
    return TextFormField(
      controller: controller,
      obscureText: secureText,
      maxLines: maxLine,
      key: textFormFieldKey,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: GlobalVariables.secondaryColor,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: GlobalVariables.blackColor,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter $hintText';
        }
        return null;
      },
    );
  }
}
