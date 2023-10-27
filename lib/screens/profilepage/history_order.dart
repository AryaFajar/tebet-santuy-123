import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  List<Map<String, dynamic>> orders = [];
  Map<int, String> anakNames = {};
  Map<String, String> orderTypeNames = {};
  Map<int, String> menuNames = {};

  @override
  void initState() {
    super.initState();
    getOrders();
    getAnakNames();

    getMenuNames();
  }

  Future<void> getAnakNames() async {
    final response = await http.get(
      Uri.parse(
          'URL_ENDPOINT_ANAK'), // Replace with the correct URL endpoint for anak
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (mounted) {
        setState(() {
          anakNames = Map.fromIterable(data,
              key: (anak) => anak['id'], value: (anak) => anak['nama_anak']);
        });
      }
    }
  }

  Future<void> getMenuNames() async {
    final response = await http.get(
      Uri.parse('URL_ENDPOINT_MENU'), // Ganti dengan URL endpoint menu
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (mounted) {
        setState(() {
          menuNames = Map.fromIterable(data,
              key: (menu) => menu['id'], value: (menu) => menu['nama_menu']);
        });
      }
    }
  }

  Future<void> getOrders() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int userId = preferences.getInt('customer_id') ?? 0;

    if (userId != 0) {
      final response = await http.get(
        Uri.parse(
            'https://07b2-180-245-55-3.ngrok-free.app/api/order?customerid=$userId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (mounted) {
          setState(() {
            orders = List<Map<String, dynamic>>.from(data);
            orders.sort((a, b) {
              DateTime timestampA = DateTime.parse(a['created_at']);
              DateTime timestampB = DateTime.parse(b['created_at']);
              return timestampB.compareTo(timestampA);
            });
          });
        }
      }
    }
  }

  Color getStatusColor(String? status) {
    if (status == 'baru') {
      return Colors.blue;
    } else if (status == 'sedang dimasak') {
      return Colors.orange;
    } else if (status == 'selesai') {
      return Colors.green;
    }
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
      body: orders.isEmpty
          ? Center(child: Text('Tidak ada data pesanan'))
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      // Tambahkan tindakan ketika kartu ditekan
                    },
                    child: Stack(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                'ID Pesanan: ${order['id']}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              title:
                                  Text('Tipe Pesanan: ${order['order_type']}'),
                            ),
                            ListTile(
                              title: Text(
                                  'Tanggal Pesanan: ${order['order_date']}'),
                            ),
                            ListTile(
                              title:
                                  Text('Anak: ${anakNames[order['anak_id']]}'),
                            ),
                            ListTile(
                              title:
                                  Text('Menu: ${menuNames[order['menu_id']]}'),
                            ),
                            ListTile(
                              title: Text('Notes: ${order['notes']}'),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: getStatusColor(order['status']),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(4),
                              ),
                            ),
                            child: Text(
                              'Status: ${order['status']}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
