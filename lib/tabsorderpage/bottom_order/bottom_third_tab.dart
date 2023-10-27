import 'dart:convert';

import 'package:appcatering/helper/constant.dart';

import 'package:appcatering/networks/api.dart';
import 'package:appcatering/tabsorderpage/ordertypepage/Third_tab.dart';
import 'package:appcatering/tabsorderpage/snack_list_tile.dart';
import 'package:appcatering/tabsorderpage/success/success.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThirdBottomOrderPage extends StatefulWidget {
  final int totalHarga;
  final String menuName;
  final int menuPrice;
  final String menuDescription;

  final String? selectedAnak;

  // Pass selected room as a String
  final List<Snack> selectedSnacks; // Change the type to Snack
  final String notes;

  final String orderType;
  final DateTime tanggal;
  const ThirdBottomOrderPage(
      {required this.totalHarga,
      required this.menuName,
      required this.menuPrice,
      required this.menuDescription,
      required this.selectedSnacks,
      required this.orderType,
      required this.selectedAnak,
      required this.tanggal, // Inisialisasi daftar anak yang dipilih
      required this.notes,
      super.key});

  @override
  State<ThirdBottomOrderPage> createState() => _ThirdBottomOrderPageState();
}

class _ThirdBottomOrderPageState extends State<ThirdBottomOrderPage> {
  final String apiEndpoint = '$apiUrl/order/create';
  void showCenteredSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void createOrderThird() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final customerID = preferences.getInt('customer_id');

    if (customerID == null) {
      // Handle jika customer_id tidak tersedia
      return;
    }

    final customerBalance = preferences.getInt('balance');

    if (customerBalance == null) {
      // Handle jika saldo pelanggan tidak tersedia di shared preferences
      return;
    }

    if (widget.selectedSnacks.isEmpty) {
      // Tampilkan pesan kesalahan jika pengguna belum memilih snack
      print('Gagal membuat pesanan. Pilih setidaknya satu snack.');
      return;
    }

    // Hitung total harga pesanan
    final totalHargaPesanan = widget.totalHarga;

    if (totalHargaPesanan > customerBalance) {
      // Handle jika saldo pelanggan tidak mencukupi
      print('Gagal membuat pesanan. Saldo pelanggan tidak mencukupi.');
      return;
    }

    final orderData = {
      'customer_id': customerID.toString(),
      'order_date': DateTime.now().toLocal().toString().split(' ')[0],
      'order_type': widget.orderType,
      'menu_id': widget.menuName.toString(),
      'untuk_tgl': widget.tanggal.toString(),
      'anak_id': widget.selectedAnak.toString(),
      'snack_id': widget.selectedSnacks.map((snack) => snack.namaSnack).join(),
      'notes': widget.notes.toString(),
    };

    final result =
        await API().postRequest(route: '/order/create', data: orderData);

    final response = jsonDecode(result.body);
    print('Order Response: $response');

    if (response != null &&
        response['success'] == "Data pesanan berhasil dibuat.") {
      // Potong saldo pelanggan dan perbarui saldo di shared preferences dan backend.
      final updatedBalance = customerBalance - totalHargaPesanan;

      // Simpan saldo yang diperbarui di shared preferences
      await preferences.setInt('balance', updatedBalance);

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SuccessAnimationPage(
                totalHarga: widget.totalHarga,
                updatedBalance: updatedBalance,
              )));

      // Perbarui saldo pelanggan di backend
      final updateBalanceData = {
        'id': customerID.toString(),
        'balance': updatedBalance.toString(),
      };

      final updateBalanceResult = await API().postRequest(
          route: '/customer/update/$customerID', data: updateBalanceData);

      final updateBalanceResponse = jsonDecode(updateBalanceResult.body);
      print('Update Balance Response: $updateBalanceResponse');
      print('balance');
    } else {
      // Handle jika pesanan tidak berhasil dibuat.
      print('Gagal membuat pesanan. Respon: $response');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Total",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  '\P${widget.totalHarga}',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    createOrderThird();
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      )),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)))),
                  child: Text(
                    "Pesan",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
