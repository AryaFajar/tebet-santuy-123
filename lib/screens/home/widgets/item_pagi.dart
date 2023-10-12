import 'package:appcatering/widget/custom_horizontal_list/custom_horizontal_list.dart';
import 'package:flutter/material.dart';

class ItemPagi extends StatelessWidget {
  final DateTime selectedDate;

  const ItemPagi({Key? key, required this.selectedDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomHorizontalList(
      title: 'Snack Pagi',
      selectedDate: selectedDate,
    );
  }
}
