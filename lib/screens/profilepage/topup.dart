import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TopUp extends StatefulWidget {
  const TopUp({Key? key}) : super(key: key);

  @override
  State<TopUp> createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  final TextEditingController _amountController = TextEditingController();

  void _topUpBalance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int userId = preferences.getInt('customer_id') ?? 0;
    int amount = int.tryParse(_amountController.text) ?? 0;

    if (userId != 0 && amount > 0) {
      int currentBalance =
          preferences.getInt('balance') ?? 0; // Ambil saldo saat ini
      int newBalance =
          currentBalance + amount; // Tambahkan saldo yang diisi ulang

      // Kirim permintaan ke server untuk memproses penambahan saldo
      final response = await http.post(
        Uri.parse('http://10.254.127.210:8000/api/customer/update/$userId'),
        body: {
          'balance': newBalance.toString()
        }, // Kirim saldo yang telah diupdate
      );

      if (response.statusCode == 200) {
        // Berhasil menambahkan saldo di server
        // Update saldo di Shared Preferences
        preferences.setInt('balance', newBalance);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Saldo berhasil ditambahkan'),
        ));
        Navigator.pop(
            context, newBalance); // Kembalikan saldo yang telah diupdate
      } else {
        // Gagal menambahkan saldo
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Gagal menambahkan saldo'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TOP UP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.price_change,
                size: 100,
              ),
              SizedBox(height: 16),
              Text(
                'Isi Saldo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Jumlah Saldo',
                  prefixIcon: Icon(Icons.monetization_on),
                ),
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: _topUpBalance,
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
                  'Tambah Saldo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
