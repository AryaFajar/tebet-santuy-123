import 'dart:convert';

import 'package:appcatering/helper/constant.dart';
import 'package:appcatering/screens/home/home.dart';
import 'package:appcatering/tabsorderpage/mainorderpage/orderpage.dart';
import 'package:appcatering/tabsorderpage/bottom_order/bottom_second_tab.dart';
import 'package:appcatering/tabsorderpage/category_orderpage.dart';
import 'package:appcatering/tabsorderpage/dropdown.dart';
import 'package:appcatering/tabsorderpage/order_bottomnavbar.dart';
import 'package:appcatering/tabsorderpage/snack_list_tile.dart';
import 'package:appcatering/tabsorderpage/switchflutter.dart';
import 'package:appcatering/tabsorderpage/test.dart';
import 'package:appcatering/widget/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:icon_forest/amazingneoicons.dart';
import 'package:icon_forest/icon_forest.dart';
import 'package:icon_forest/flat_icons_medium.dart';
import 'package:icon_forest/iconoir.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabOrderAnak extends StatefulWidget {
  final String orderType;
  final String menuName;
  final int price;
  final DateTime tanggal;

  // Tambahkan variabel harga snack
  final String description;

  TabOrderAnak({
    required this.orderType,
    required this.menuName,
    required this.price,
    required this.description,
    required this.tanggal,
    super.key,
  });

  @override
  State<TabOrderAnak> createState() => _TabOrderAnakState();
}

class AnakItem {
  final int id; // ID anak
  final String namaAnak;
  final String kelas;

  bool isSelected;
  bool isSwitchOn;

  AnakItem({
    required this.id,
    required this.namaAnak,
    required this.kelas,
    this.isSelected = false,
    this.isSwitchOn = false,
  });
}

class _TabOrderAnakState extends State<TabOrderAnak> {
  TextEditingController notesController = TextEditingController();

  bool isSelected = false;
  bool isSwitchOn = false;
  late Future<List<Snack>> _snacks;
  List<Snack> selectedSnacks = [];
  List<AnakItem> anakList = [];
  List<AnakItem> selectedAnak = [];
  int totalHarga = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
    _snacks = _fetchSnacks();
    totalHarga = widget.price;
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

  Future<void> fetchData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int customerId = preferences.getInt('customer_id') ?? 0;

    // Ganti URL di bawah ini dengan URL API yang sesuai
    final response =
        await http.get(Uri.parse('$apiUrl/anak?customerid=$customerId'));
    if (response.statusCode == 200) {
      final List<dynamic> decodedList = jsonDecode(response.body);
      if (mounted) {
        // check whether the state object is in tree
        setState(() {
          anakList = decodedList
              .map((anak) => AnakItem(
                    id: anak['id'],
                    namaAnak: anak['nama_anak'],
                    kelas: anak['kelas'],
                  ))
              .toList();
        });
      }
    } else {
      throw Exception('Failed to load anak data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: 16.0,
              left: 16.0,
              right: 16.0), // Sesuaikan jarak dari kiri dan kanan

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
                        fontSize:
                            24, // Ubah sesuai dengan ukuran teks yang diinginkan
                        fontWeight: FontWeight.bold, // Sesuaikan gaya teks
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    '\P${widget.price}',
                    style: TextStyle(
                      fontSize:
                          20, // Ubah sesuai dengan ukuran teks yang diinginkan
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.0), // Jarak antara judul dan deskripsi

              Text(
                widget.description,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 24.0),
              const Divider(
                thickness: 2,
              ),
              OrderCategoryHeader(
                  title: 'Untuk Ananda?',
                  icon: Icons.child_care,
                  iconColor: Colors.black),
              SizedBox(height: 24.0),

              ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: anakList.length,
                itemBuilder: (context, index) {
                  final anak = anakList[index];
                  return ListTile(
                    leading: Checkbox(
                      value: anak.isSelected,
                      onChanged: (newValue) {
                        setState(() {
                          anak.isSelected = newValue ?? false;
                          if (!anak.isSelected) {
                            anak.isSwitchOn = false;
                          }
                          if (anak.isSelected) {
                            print('ID anak yang dipilih: ${anak.namaAnak}');
                            selectedAnak.add(
                                anak); // Tambahkan anak ke dalam daftar selectedAnak saat dipilih
                          } else {
                            selectedAnak.remove(
                                anak); // Hapus anak dari daftar selectedAnak saat tidak dipilih
                          }
                        });
                      },
                    ),
                    title: Text(
                      anak.namaAnak,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      anak.kelas,
                      style: TextStyle(
                        fontSize: 16,
                        color: anak.isSelected ? Colors.black : Colors.grey,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 24),
              InputField(
                  controller: notesController, hintText: 'Pedas / Tidak Pedas'),
              const Divider(
                thickness: 2,
              ),
              OrderCategoryHeader(
                  title: 'Mau Tambah Snacks?',
                  icon: Icons.cookie,
                  iconColor: Colors.black),

              SizedBox(height: 8.0),
              const Divider(
                thickness: 1,
              ),
              FutureBuilder<List<Snack>>(
                future: _snacks,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final snacks = snapshot.data!;
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

                                    // Setel selectedSnackName dengan nama snack yang dipilih
// Tambahkan snack yang dipilih ke list selectedSnacks
                                  } else {
                                    selectedSnacks.remove(
                                        snack); // Hapus snack yang tidak dipilih dari list selectedSnacks
                                  }
                                  print(selectedSnacks);

// Tambahkan ini untuk memeriksa data snack yang terpilih
                                }); // Tambahkan callback ini
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
      bottomNavigationBar: SecondBottomOrderPage(
        totalHarga: totalHarga,
        menuName: widget.menuName,
        menuPrice: widget.price,
        menuDescription: widget.description,
        selectedSnacks: selectedSnacks,
        orderType: widget.orderType,
        selectedAnak: selectedAnak,
        tanggal: widget.tanggal,
        notes: notesController.text,
      ),
    );
  }
}
