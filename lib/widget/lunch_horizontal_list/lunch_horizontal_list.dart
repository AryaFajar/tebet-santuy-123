import 'package:flutter/material.dart';
import 'package:appcatering/widget/custom_horizontal_list/horizontal_list_header.dart';
// import 'package:equatable/equatable.dart';
import 'package:async/async.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class LunchHorizontalList extends StatefulWidget {
  final String title;
  final DateTime selectedDate;

  const LunchHorizontalList({
    Key? key,
    required this.title,
    required this.selectedDate,
  }) : super(key: key);

  @override
  _LunchHorizontalListState createState() => _LunchHorizontalListState();
}

class _LunchHorizontalListState extends State<LunchHorizontalList> {
  final memoizer = AsyncMemoizer<List<Menu>>();

  Future<List<Menu>> fetchMenuData(DateTime selectedDate) async {
    try {
      final response = await http
          .get(Uri.parse("https://ea81-180-251-181-5.ngrok-free.app/api/menu"));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(response.body);

        final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
        print("Formatted Date: $formattedDate");

        final List<dynamic> menuList = data['menu'];
        final List<Menu> filteredData = menuList
            .where((menu) =>
                menu['category_id'] == 2 && menu['tanggal'] == formattedDate)
            .map((json) => Menu.fromJson(json))
            .toList();

        return filteredData;
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
      future: fetchMenuData(widget.selectedDate), // Pass the selectedDate here
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return Column(
              children: [
                HorizontalListHeader(title: widget.title),
                const SizedBox(height: 10),
                Text('No data available'),
              ],
            );
          } else {
            return Column(
              children: [
                HorizontalListHeader(title: widget.title),
                const SizedBox(height: 10),
                LunchHorizontalListBody(
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
  final String price;

  Menu({
    required this.name,
    required this.image,
    required this.price,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      name: json['nama_menu'],
      image: json['gambar'],
      price: json['harga'],
    );
  }
}

class LunchHorizontalListBody extends StatelessWidget {
  final List<Menu> menuData;

  LunchHorizontalListBody({
    required this.menuData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const SizedBox(height: 10),
          HorizontalListBody(menuData: menuData),
        ],
      ),
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Tindakan yang ingin Anda lakukan ketika item diklik
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
                        '\P${menu.price}',
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
