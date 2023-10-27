import 'package:appcatering/shopping_cart/widgets/shopping_cart_empty.dart';
import 'package:appcatering/shopping_cart/widgets/shopping_cart_header.dart';
import 'package:appcatering/widget/custom_button.dart';
import 'package:flutter/material.dart';

class BodyCart extends StatelessWidget {
  const BodyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          ShoppingCartHeader(),
          ShoppingCartEmpty(),
        ],
      ),
    );
  }
}
