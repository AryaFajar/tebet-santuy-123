import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:appcatering/networks/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnakListPage extends StatefulWidget {
  final int customerId;

  AnakListPage({required this.customerId});
  @override
  _AnakListPageState createState() => _AnakListPageState();
}

class _AnakListPageState extends State<AnakListPage> {
  List<Map<String, dynamic>> anakList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int customerId = preferences.getInt('customer_id') ??
        0; // Get the customer ID from preferences
    final result =
        await API().getRequest(route: '/anak?customerid=$customerId');

    // Parse the JSON response and update anakList
    final List<dynamic> decodedList = jsonDecode(result.body);
    setState(() {
      anakList = decodedList.cast<Map<String, dynamic>>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Anak'),
      ),
      body: ListView.builder(
        itemCount: anakList.length,
        itemBuilder: (context, index) {
          final anak = anakList[index];
          return ListTile(
            title: Text(anak['nama_anak']),
            subtitle: Text(anak['kelas']),
            // You can add other UI elements as needed
          );
        },
      ),
    );
  }
}
