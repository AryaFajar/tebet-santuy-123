import 'package:flutter/material.dart';

class HorizontalListHeader extends StatelessWidget {
  final String title;

  const HorizontalListHeader({
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
    return Row(
      children: [
        Text(
          'Lihat Semua',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 5),
        Image.asset(
          'assets/images/right_arrow.png',
          width: 15,
        )
      ],
    );
  }
}
