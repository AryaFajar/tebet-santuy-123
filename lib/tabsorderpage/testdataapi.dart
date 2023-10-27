import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:appcatering/networks/api.dart';

class TestApiPage extends StatefulWidget {
  @override
  State<TestApiPage> createState() => _TestApiPageState();
}

class _TestApiPageState extends State<TestApiPage> {
  final String apiEndpoint = 'http://10.254.127.213:8000/api/order/create';

  void createOrder() async {
    final orderData = {
      'customer_id': '1', // Ganti dengan ID pelanggan yang valid
      'order_date': DateTime.now().toIso8601String(),
      'order_type': 'diri_sendiri', // Ganti dengan order_type yang sesuai
      'menu_id': 'Nasi Goreng',
      'anak_id': 'radit', // Ganti dengan ID menu yang valid
      'ruang_id': 'RUANG B', // Ganti dengan ID ruang yang valid
      'snack_id': 'Biscuit', // Ganti dengan ID snack yang valid
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    };

    final result = await API().postRequest(
      route: '/order/create', // Ganti dengan rute yang sesuai
      data: orderData,
    );

    final response = jsonDecode(result.body);
    print('Order Response: $response');

    if (response != null &&
        response['success'] == "Data pesanan berhasil dibuat.") {
      // Pesanan berhasil dibuat, Anda dapat menampilkan pesan sukses atau navigasi ke halaman lain.

      // Selanjutnya, potong saldo pengguna dan perbarui saldo di backend.
    } else {
      // Handle jika pesanan tidak berhasil dibuat.
      print('Gagal membuat pesanan. Respon: $response');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test API Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                createOrder();
              },
              style: ElevatedButton.styleFrom(primary: Colors.blue),
              child: Text(
                "Pesan",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
