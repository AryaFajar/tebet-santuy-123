import 'package:appcatering/widget/custom_vertical_list/vertical_list.dart';
import 'package:flutter/material.dart';
import 'package:appcatering/widget/horizontal_list.dart';

class SeeAllPage extends StatelessWidget {
  final String categoryTitle;
  final int category;
  final DateTime selectedDate;

  SeeAllPage({
    required this.categoryTitle,
    required this.category,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lihat Semua $categoryTitle'), // Judul halaman
      ),
      body: VerticalList(
        title: categoryTitle,
        category: category,
        selectedDate: selectedDate,
        showAll:
            true, // Beri tahu widget HorizontalList untuk menampilkan semua item
      ),
    );
  }
}
