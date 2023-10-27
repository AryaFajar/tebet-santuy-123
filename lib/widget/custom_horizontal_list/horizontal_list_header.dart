import 'package:flutter/material.dart';

class HorizontalListHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onShowAllPressed;

  const HorizontalListHeader({
    this.onShowAllPressed,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          buildShowAllButton(),
        ],
      ),
    );
  }

  Widget buildShowAllButton() {
    return GestureDetector(
      onTap: onShowAllPressed, // Memanggil callback onShowAllPressed
      child: Row(
        children: [
          Text(
            'Lihat Semua',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18,
            ),
          ),
          const SizedBox(width: 5),
          Image.asset(
            'assets/images/right_arrow.png',
            width: 15,
          ),
        ],
      ),
    );
  }
}
