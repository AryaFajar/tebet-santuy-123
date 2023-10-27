import 'package:appcatering/shopping_cart/widgets/shopping_cart_empty.dart';
import 'package:flutter/material.dart';
import 'package:appcatering/tabsorderpage/order.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartPage extends StatefulWidget {
  final List<Order> orders;

  CartPage({required this.orders});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Order> orders = [];

  @override
  void initState() {
    super.initState();
    loadOrdersFromSharedPreferences();
  }

  void loadOrdersFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final orderListJson = prefs.getString('orders');
    if (orderListJson != null) {
      final orderList = jsonDecode(orderListJson) as List;
      final loadedOrders =
          orderList.map((orderJson) => Order.fromJson(orderJson)).toList();
      setState(() {
        orders.clear(); // Clear the existing cart

        orders.addAll(loadedOrders); // Load saved orders
      });
    }
  }

  Future<void> saveOrdersToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final orderList = orders.map((order) => order.toJson()).toList();
    await prefs.setString('orders', jsonEncode(orderList));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
      ),
      body: orders.isEmpty
          ? ShoppingCartEmpty()
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return ListTile(
                  title: Text('Menu: ${order.menuName}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Harga: \P${order.menuPrice}'),
                      Text('Ruangan: ${order.selectedRoom}'),
                      Text('Tipe Pesanan: ${order.orderType}'),
                      Text('Snacks:'),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: order.selectedSnacks.map((snack) {
                          return Text('${snack.namaSnack} - \P${snack.harga}');
                        }).toList(),
                      ),
                      Text('Total Harga: \P${order.totalHarga}'),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
