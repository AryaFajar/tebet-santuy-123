import 'package:flutter/material.dart';

class CustomAppBarIcon extends StatelessWidget {
  final String image;
  final double size;
  final Function() onPressed;

  const CustomAppBarIcon({
    super.key,
    required this.image,
    this.size = 30,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: onPressed,
        child: Image.asset(
          image,
          width: size,
          height: size,
        ),
      ),
    );
  }
}
