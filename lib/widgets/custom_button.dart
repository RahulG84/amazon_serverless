import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  void Function()? onPressed;
  String buttonTile;
  Color? backgroundColor;
  Color? buttonTitleColor;
  CustomButton(
      {Key? key,
      required this.onPressed,
      required this.buttonTile,
      this.backgroundColor,
      this.buttonTitleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(
        buttonTile,
        style: TextStyle(
          color: buttonTitleColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
