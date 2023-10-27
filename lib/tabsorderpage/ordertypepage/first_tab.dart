import 'package:appcatering/helper/constant.dart';
import 'package:appcatering/tabsorderpage/mainorderpage/orderpage.dart';
import 'package:appcatering/tabsorderpage/category_orderpage.dart';
import 'package:appcatering/tabsorderpage/dropdown.dart';
import 'package:appcatering/tabsorderpage/order.dart';
import 'package:appcatering/tabsorderpage/bottom_order/bottom_first_tab.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:appcatering/tabsorderpage/snack_list_tile.dart';
import 'package:appcatering/tabsorderpage/order_bottomnavbar.dart';

class TabOrderAnda extends StatefulWidget {
  final String menuName;
  final int price;

  final String description;
  final String orderType;
  final DateTime tanggal;
  final int category;

  TabOrderAnda({
    Key? key,
    required this.menuName,
    required this.price,
    required this.orderType,
    required this.tanggal,
    required this.description,
    required this.category,
  }) : super(key: key);

  @override
  State<TabOrderAnda> createState() => _TabOrderAndaState();
}

class _TabOrderAndaState extends State<TabOrderAnda> {
  late Future<List<Snack>> _snacks;
  List<Snack> selectedSnacks = []; // Tambahkan variabel ini

  int totalHarga = 0;
  Ruangan? selectedRoom;

  @override
  void initState() {
    super.initState();
    _snacks = _fetchSnacks();
    totalHarga = widget.price;

    // Set default totalHarga to food price
  }

  Future<List<Snack>> _fetchSnacks() async {
    final response = await http.get(Uri.parse('$apiUrl/snack'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['snacks'] as List;
      return data
          .map((json) => Snack(
                id: json['id'],
                namaSnack: json['nama_snack'],
                gambar: json['gambar'],
                deskripsi: json['deskripsi'],
                harga: json['harga'],
              ))
          .toList();
    } else {
      throw Exception('Gagal mengambil data snack');
    }
  }

  void onRoomSelected(Ruangan room) {
    if (mounted) {
      setState(() {
        selectedRoom = room;
      });
    }
  }

  void onSnackAdded(int harga) {
    setState(() {
      totalHarga += harga;
    });
    print('Total Harga: ${totalHarga}');
  }

  void onSnackRemoved(int harga) {
    if (selectedSnacks.isNotEmpty) {
      setState(() {
        totalHarga -= harga;
        print('Total Harga: ${totalHarga}');
      });
    }
    print('Total Harga: ${totalHarga}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 16.0,
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.menuName,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    '\P${widget.price}',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.0),
              Text(
                widget.description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 24.0),
              const Divider(
                thickness: 2,
              ),
              OrderCategoryHeader(
                  title: 'Pilih Ruangan',
                  icon: Icons.room,
                  iconColor: Colors.black),
              SizedBox(height: 8.0),
              DropDownRuangan(onRoomSelected: onRoomSelected),
              const Divider(
                thickness: 2,
              ),
              OrderCategoryHeader(
                  title: 'Mau Tambah Snacks?',
                  icon: Icons.cookie,
                  iconColor: Colors.black),
              SizedBox(height: 8.0),
              const Divider(thickness: 1),
              FutureBuilder<List<Snack>>(
                future: _snacks,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final snacks = snapshot.data!;
                    for (var snack in snacks) {
                      // Cek apakah snack sudah dipilih
                      snack.isSelected = selectedSnacks.contains(snack);
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snacks.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SnackListTile(
                            name: snacks[index].namaSnack,
                            image: snacks[index].gambar,
                            description: snacks[index].deskripsi,
                            harga: snacks[index].harga,
                            snack: snacks[index], // Tambahkan ini

                            onSnackAdded: onSnackAdded,
                            onSnackRemoved: onSnackRemoved,
                            onSnackSelected: (snack, isSelected) {
                              if (mounted) {
                                setState(() {
                                  if (isSelected) {
                                    selectedSnacks.add(snack);
                                  } else {
                                    selectedSnacks.remove(snack);
                                  }
                                  snack.isSelected =
                                      isSelected; // Atur properti isSelected
                                  print(selectedSnacks);
                                });
                              }
                            });
                      },
                    );
                  } else {
                    return Text('Tidak ada data snack.');
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: FirstBottomOrderPage(
        totalHarga: totalHarga,
        menuName: widget.menuName,
        menuPrice: widget.price,
        menuDescription: widget.description,

        selectedRoom: selectedRoom?.namaRuangan ?? '', // Tambahkan ini
        selectedSnacks: selectedSnacks,
        orderType: widget.orderType,
        tanggal: widget.tanggal,
        category: widget.category,
      ),
    );
  }
}
