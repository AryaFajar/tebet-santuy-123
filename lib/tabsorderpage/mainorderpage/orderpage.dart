import 'package:appcatering/tabsorderpage/cart.dart';
import 'package:flutter/material.dart';
import 'package:appcatering/tabsorderpage/ordertypepage/first_tab.dart';
import 'package:appcatering/tabsorderpage/ordertypepage/second_tab.dart';
import 'package:appcatering/tabsorderpage/ordertypepage/third_tab.dart';

class OrderPage extends StatefulWidget {
  final String MenuName;
  final int price;
  final String imageUrl;
  final String description;
  String orderType = '';
  final DateTime tanggal;
  final int category;

  OrderPage({
    required this.MenuName,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.tanggal,
    required this.category,
  });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  // Tambahkan parameter orderType
  late TabController _tabController;
  // List untuk menyimpan pesanan

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        // Tab sedang berubah, jadi Anda dapat menambahkan penundaan di sini
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            // Perubahan tab setelah penundaan
            _tabController.animateTo(_tabController.index);
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
                  bottomLeft: Radius.circular(50),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.imageUrl),
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
            ),
          ),
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
                onTap: (index) {
                  setState(() {
                    if (index == 0) {
                      widget.orderType = 'diri_sendiri';
                    } else if (index == 1) {
                      widget.orderType = 'anak';
                    } else if (index == 2) {
                      widget.orderType = 'orang_lain';
                    }
                  });
                },
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // Order Anda
                    TabOrderAnda(
                      key: UniqueKey(),
                      menuName: widget.MenuName,
                      price: widget.price,
                      description: widget.description,
                      orderType: widget.orderType,
                      tanggal: widget.tanggal,
                      category: widget.category,
                    ),
                    // Order Anak
                    TabOrderAnak(
                      key: UniqueKey(),
                      menuName: widget.MenuName,
                      price: widget.price,
                      description: widget.description,
                      orderType: widget.orderType,
                      tanggal: widget.tanggal,
                    ),
                    // Order Lainnya
                    TabOrderLainnya(
                      menuName: widget.MenuName,
                      price: widget.price,
                      description: widget.description,
                      orderType: widget.orderType,
                      tanggal: widget.tanggal,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
