import 'package:appcatering/tabsorderpage/first_tab.dart';
import 'package:appcatering/tabsorderpage/second_tab.dart';
import 'package:appcatering/tabsorderpage/third_tab.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  final String MenuName;
  final double price;
  final String imageUrl;

  const OrderPage({
    this.MenuName = 'Nama Makanan',
    this.price = 0.0,
    this.imageUrl = 'https://via.placeholder.com/150',
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: MaterialApp(
        home: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(200),
              child: AppBar(
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                flexibleSpace: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50)),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/nasigoreng1.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                backgroundColor: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                ),
              )),

          // extendBodyBehindAppBar: false,
          body: Column(
            children: [
              SizedBox(height: 16),
              TabBar(
                tabs: [
                  Tab(
                    child: Text(
                      'Anda',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Anak',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Lainnya',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(children: [
                  // Order Anda
                  TabOrderAnda(),

                  // Order Anak
                  TabOrderAnak(),

                  // Order Lainnya
                  TabOrderLainnya(),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
