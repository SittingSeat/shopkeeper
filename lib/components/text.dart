import 'package:flutter/material.dart';

class ShopkeeperMainText extends StatelessWidget {
  final String text;
  final double verticalPadding;
  final double horizontalPadding;

  const ShopkeeperMainText(
      {required this.text,
        required this.verticalPadding,
        required this.horizontalPadding,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class ShopkeeperSubText extends StatelessWidget {
  final String text;
  final double verticalPadding;
  final double horizontalPadding;

  const ShopkeeperSubText({required this.text, required this.verticalPadding, required this.horizontalPadding, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

