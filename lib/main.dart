import 'package:appcatering/food_service.dart';
import 'package:appcatering/homepage.dart';
import 'package:appcatering/screens/account.dart';
import 'package:appcatering/screens/home/home.dart';
import 'package:appcatering/screens/home/home_page.dart';
import 'package:appcatering/screens/home/widgets/body.dart';
import 'package:appcatering/screens/home/widgets/item_pagi.dart';
import 'package:appcatering/shopping_cart/cart.dart';
import 'package:appcatering/screens/orderpage.dart';
import 'package:appcatering/shopping_cart/widgets/body.dart';
import 'package:appcatering/tabsorderpage/dropdown.dart';
import 'package:appcatering/tabsorderpage/first_tab.dart';
import 'package:appcatering/tabsorderpage/second_tab.dart';
import 'package:appcatering/tabsorderpage/switchflutter.dart';
import 'package:appcatering/tabsorderpage/test.dart';
import 'package:appcatering/tabsorderpage/third_tab.dart';
import 'package:appcatering/testapi.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ); //Material PageApp
  }
}
