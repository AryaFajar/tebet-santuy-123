import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        textStyle: MaterialStateProperty.all(
          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
      child: Text(title),
    );
  }
}
