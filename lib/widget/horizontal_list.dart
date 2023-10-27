import 'package:appcatering/helper/constant.dart';
import 'package:appcatering/widget/custom_vertical_list/seeallpage.dart';
import 'package:appcatering/tabsorderpage/mainorderpage/orderpage.dart';

import 'package:flutter/material.dart';
import 'package:appcatering/widget/custom_horizontal_list/horizontal_list_header.dart';
import 'package:async/async.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HorizontalList extends StatefulWidget {
  final String title;
  final int category;
  final DateTime selectedDate;
  final bool showAll;
  final bool showHeader; // Tambahkan parameter ini

  HorizontalList({
    Key? key,
    required this.title,
    required this.category,
    required this.selectedDate,
    this.showAll = false,
    this.showHeader = true, // Set defaultnya menjadi true
  }) : super(key: key);

  @override
  _HorizontalListState createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  final memoizer = AsyncMemoizer<List<Menu>>();

  Future<List<Menu>> fetchMenuData() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/menu'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(response.body);

        final formattedDate =
            DateFormat('yyyy-MM-dd').format(widget.selectedDate);
        print("Formatted Date: $formattedDate");

        final List<dynamic> menuList = data['menu'];
        List<Menu> filteredData = menuList
            .where((menu) =>
                menu['category_id'] == widget.category &&
                menu['tanggal'] == formattedDate)
            .map((json) => Menu.fromJson(json))
            .toList();

        // Cek apakah kita ingin menampilkan semua item atau hanya 3 item
        if (widget.showAll) {
          // Jika di halaman 'SeeAllPage', tampilkan semua item
          return filteredData;
        } else {
          // Jika di halaman lain, batasi jumlah item yang ditampilkan menjadi 3
          filteredData = filteredData.take(3).toList();
          return filteredData;
        }
      } else {
        print('Failed to load menu data - ${response.statusCode}');
        return []; // Return an empty list to indicate no data available
      }
    } catch (error) {
      print('Error fetching menu data - $error');
      return []; // Return an empty list to indicate no data available
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Menu>>(
      future: fetchMenuData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return Column(
              children: [
                if (widget.showHeader)
                  HorizontalListHeader(
                    title: widget.title,
                    onShowAllPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeeAllPage(
                            categoryTitle: widget.title,
                            category: widget.category,
                            selectedDate: widget.selectedDate,
                          ),
                        ),
                      );
                    },
                  ),
                const SizedBox(height: 10),
                Text('No data available'),
              ],
            );
          } else {
            return Column(
              children: [
                if (widget.showHeader)
                  HorizontalListHeader(
                    title: widget.title,
                    onShowAllPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeeAllPage(
                            categoryTitle: widget.title,
                            category: widget.category,
                            selectedDate: widget.selectedDate,
                          ),
                        ),
                      );
                    },
                  ),
                const SizedBox(height: 10),
                HorizontalListBody(
                  menuData: snapshot.data!,
                ),
              ],
            );
          }
        } else {
          return Column(
            children: [
              HorizontalListHeader(title: widget.title),
              const SizedBox(height: 10),
              Text('No data available'),
            ],
          );
        }
      },
    );
  }
}

class Menu {
  final String name;
  final String image;
  final int price;
  final String description;
  final DateTime tanggal;
  final int category;

  Menu({
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.tanggal,
    required this.category,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      name: json['nama_menu'],
      image: json['gambar'],
      price: json['harga'] as int,
      description: json['deskripsi'],
      tanggal: DateTime.parse(json['tanggal']),
      category: json['category_id'] as int,
    );
  }
}

class HorizontalListBody extends StatelessWidget {
  final List<Menu> menuData;

  HorizontalListBody({required this.menuData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
        child: Row(
          children:
              menuData.map((menu) => HorizontalListItem(menu: menu)).toList(),
        ),
      ),
    );
  }
}

class HorizontalListItem extends StatelessWidget {
  final Menu menu;

  HorizontalListItem({required this.menu});

  void navigateToOrderPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderPage(
          MenuName: menu.name,
          price: menu.price,
          imageUrl: menu.image,
          description: menu.description,
          tanggal: menu.tanggal,
          category: menu.category,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateToOrderPage(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          width: 165,
          height: 200, // Lebar container
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
            // Sudut lengkung
          ),
          child: SizedBox(
            width: 150,
            child: Align(
              alignment: Alignment
                  .center, // Mengatur konten menjadi pusat secara horizontal
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildImageContainer(menu.image),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        menu.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18), // Mengurangi ukuran teks judul
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\P${menu.price.toString()}',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14), // Mengurangi ukuran teks harga
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImageContainer(String imageUrl) {
    return Stack(
      children: [
        Image.network(
          imageUrl,
          width: 150,
          height: 120, // Mengurangi ukuran gambar
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
