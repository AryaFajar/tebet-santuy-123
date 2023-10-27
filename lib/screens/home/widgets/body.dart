import 'package:flutter/material.dart';
import 'package:appcatering/screens/home/widgets/home_header.dart';
import 'package:appcatering/screens/home/widgets/item_pagi.dart';
import 'package:appcatering/screens/home/widgets/item_siang.dart';
import 'package:appcatering/screens/home/widgets/pilihtanggal.dart';
// import 'package:appcatering/widget/custom_horizontal_list/custom_horizontal_list.dart';

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';

class BodyPengguna extends StatefulWidget {
  const BodyPengguna({super.key});

  @override
  _BodyPenggunaState createState() => _BodyPenggunaState();
}

class _BodyPenggunaState extends State<BodyPengguna> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          HomeHeader(),
          PilihTanggal(
            onDateSelected: (date) {
              setState(() {
                selectedDate = date;
              });
            },
          ),
          Expanded(
            child: ListView(
              children: [
                SizedBox(height: 20),
                ItemPagi(selectedDate: selectedDate),
                SizedBox(height: 20),
                ItemSiang(selectedDate: selectedDate),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
