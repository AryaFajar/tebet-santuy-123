import 'package:appcatering/widget/horizontal_list.dart';
import 'package:appcatering/widget/lunch_horizontal_list/lunch_horizontal_list.dart';
import 'package:flutter/material.dart';

class ItemSiang extends StatelessWidget {
  final DateTime selectedDate;

  const ItemSiang({Key? key, required this.selectedDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HorizontalList(
      title: 'Makan Siang',
      category: 2,
      selectedDate: selectedDate,
    );
  }
}
