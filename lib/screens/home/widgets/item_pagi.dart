import 'package:appcatering/widget/horizontal_list.dart';
import 'package:flutter/material.dart';

class ItemPagi extends StatelessWidget {
  final DateTime selectedDate;

  const ItemPagi({Key? key, required this.selectedDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HorizontalList(
      title: 'Snack Pagi',
      category: 1,
      selectedDate: selectedDate,
    );
  }
}
