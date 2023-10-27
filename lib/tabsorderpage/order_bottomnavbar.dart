import 'package:appcatering/tabsorderpage/mainorderpage/orderpage.dart';
import 'package:flutter/material.dart';

class BottomOrderPage extends StatefulWidget {
  final int totalHarga; // Tambahkan totalHarga sebagai parameter

  BottomOrderPage({
    Key? key,
    required this.totalHarga,
  }) : super(key: key);

  @override
  _BottomOrderPageState createState() => _BottomOrderPageState();
}

class _BottomOrderPageState extends State<BottomOrderPage> {
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
                  '\P${widget.totalHarga}', // Tampilkan totalHarga dari widget
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              child: Text(
                "Keranjang",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
