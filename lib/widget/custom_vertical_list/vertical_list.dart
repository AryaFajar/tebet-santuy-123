import 'package:appcatering/tabsorderpage/mainorderpage/orderpage.dart';
import 'package:flutter/material.dart';
import 'package:appcatering/helper/constant.dart';
import 'package:async/async.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class VerticalList extends StatefulWidget {
  final String title;
  final int category;
  final DateTime selectedDate;
  final bool showAll;

  VerticalList({
    Key? key,
    required this.title,
    required this.category,
    required this.selectedDate,
    this.showAll = false,
  }) : super(key: key);

  @override
  _VerticalListState createState() => _VerticalListState();
}

class _VerticalListState extends State<VerticalList> {
  final memoizer = AsyncMemoizer<List<Menu>>();

  Future<List<Menu>> fetchMenuData() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/menu'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

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

        if (widget.showAll) {
          return filteredData;
        } else {
          return filteredData;
        }
      } else {
        print('Failed to load menu data - ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error fetching menu data - $error');
      return [];
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
            return Center(
              child: Expanded(
                child: Text(
                  'Tidak ada makanan yang tersedia pada\n${widget.title}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Menampilkan dua item per baris
                childAspectRatio:
                    0.8, // Atur rasio tinggi lebar sesuai kebutuhan Anda
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final menu = snapshot.data![index];
                return VerticalListItem(menu: menu);
              },
            );
          }
        } else {
          return Center(
            child: Text('No data available'),
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
        category: json['category_id'] as int);
  }
}

class VerticalListItem extends StatelessWidget {
  final Menu menu;

  VerticalListItem({required this.menu});

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
      child: Container(
        padding: EdgeInsets.all(10),
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
        ),
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildImageContainer(menu.image),
            const SizedBox(height: 10),
            Text(
              menu.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '\P${menu.price.toString()}',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImageContainer(String imageUrl) {
    return Image.network(
      imageUrl,
      height: 120,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
