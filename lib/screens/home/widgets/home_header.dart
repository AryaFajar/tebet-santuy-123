import 'package:appcatering/widget/custom_appbar_icon.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Text(
            'Pilih Paket\nMakananmu',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          buildNotificationIcon()
        ],
      ),
    );
  }

  Widget buildMenuIcon() {
    return CustomAppBarIcon(
        image: 'assets/images/empty_shop_cart.png', onPressed: () {});
  }

  Widget buildNotificationIcon() {
    return CustomAppBarIcon(
        image: 'assets/images/notification.png', onPressed: () {});
  }
}
