import 'package:flutter/material.dart';

class ShoppingCartHeader extends StatelessWidget {
  const ShoppingCartHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: .5, color: Colors.grey))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Text(
              'Keranjang',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            )
          ],
        ),
      ),
    );
  }
}
