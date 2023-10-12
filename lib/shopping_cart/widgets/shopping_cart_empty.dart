import 'package:appcatering/widget/custom_button.dart';
import 'package:flutter/material.dart';

class ShoppingCartEmpty extends StatelessWidget {
  const ShoppingCartEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildImage(),
            const SizedBox(height: 30),
            Text(
              'Keranjang anda saat ini kosong',
              style: TextStyle(
                color: Colors.black.withOpacity(.5),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Untungnya, ada solusi mudah.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 30),
            buildGoShoppingButton()
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    return Image.asset(
      'assets/images/empty_shop_cart.png',
      height: 300,
    );
  }

  Widget buildGoShoppingButton() {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        title: 'Pergi Belanja',
        onPressed: () {},
      ),
    );
  }
}
