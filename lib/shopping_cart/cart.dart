import 'package:appcatering/shopping_cart/widgets/body.dart';
import 'package:appcatering/themes/app_colors.dart';
import 'package:flutter/material.dart';

class UserCart extends StatelessWidget {
  const UserCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      body: BodyCart(),
    );
  }
}
