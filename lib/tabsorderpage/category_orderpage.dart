import 'package:flutter/material.dart';

class OrderCategoryHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;

  OrderCategoryHeader(
      {required this.title, required this.icon, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0, right: 16.0),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 36),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
