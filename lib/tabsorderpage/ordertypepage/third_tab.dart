import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:appcatering/helper/constant.dart';
import 'package:appcatering/tabsorderpage/bottom_order/bottom_third_tab.dart';
import 'package:appcatering/tabsorderpage/mainorderpage/orderpage.dart';
import 'package:appcatering/tabsorderpage/category_orderpage.dart';
import 'package:appcatering/tabsorderpage/snack_list_tile.dart';
import 'package:appcatering/widget/input_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:icon_forest/iconoir.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabOrderLainnya extends StatefulWidget {
  final String menuName;
  final int price;

  final String description;
  final String orderType;
  final DateTime tanggal;

  TabOrderLainnya({
    required this.orderType,
    required this.menuName,
    required this.price,
    required this.description,
    required this.tanggal,
    super.key,
  });

  @override
  _TabOrderLainnyaState createState() => _TabOrderLainnyaState();
}

class AnakItem {
  final int id;
  final String namaAnak;
  final String kelas;
  final int customerId; // Tambahkan properti customerId

  bool isSelected;
  bool isSwitchOn;

  AnakItem({
    required this.id,
    required this.namaAnak,
    required this.customerId, // Inisialisasikan properti customerId

    required this.kelas,
    this.isSelected = false,
    this.isSwitchOn = false,
  });
}

class _TabOrderLainnyaState extends State<TabOrderLainnya> {
  late Future<List<Snack>> _snacks;
  List<Snack> selectedSnacks = [];
  List<AnakItem> anakList = [];
  TextEditingController notesController = TextEditingController();
  final textController = TextEditingController();
  String? selectedAnak;
  List<String> searchSuggestions = [];
  bool isChecked = true;
  bool isSwitchOn = false;
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

  Future<void> fetchData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int loggedInCustomerId = preferences.getInt('customer_id') ?? 0;

    final data = await fetchDataFromAPI(loggedInCustomerId);

    if (mounted) {
      setState(() {
        anakList = data;
      });
    }

    textController.addListener(() {
      updateSearchSuggestions(textController.text);
    });
  }

  Future<List<AnakItem>> fetchDataFromAPI(int loggedInCustomerId) async {
    final response = await http.get(Uri.parse('$apiUrl/anak'));

    if (response.statusCode == 200) {
      final List<dynamic> decodedList = jsonDecode(response.body);
      final List<AnakItem> filteredAnakList = decodedList
          .map((anak) {
            return AnakItem(
              id: anak['id'],
              namaAnak: anak['nama_anak'],
              kelas: anak['kelas'],
              customerId: anak['customer_id'],
              isSelected: false,
              isSwitchOn: false,
            );
          })
          .where((anak) => anak.customerId != loggedInCustomerId)
          .toList();

      return filteredAnakList;
    } else {
      throw Exception('Gagal mengambil data anak');
    }
  }

  void updateSearchSuggestions(String query) {
    setState(() {
      searchSuggestions = anakList
          .where((anak) =>
              anak.namaAnak.toLowerCase().contains(query.toLowerCase()))
          .map((anak) => anak.namaAnak)
          .toList();

      if (searchSuggestions.isEmpty && query.isNotEmpty) {
        textController.clear();
      }
    });
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

  Widget _buildSelectedOrSuggestionItem() {
    return Column(
      children: [
        if (searchSuggestions.isNotEmpty)
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: searchSuggestions.map((suggestion) {
                return ListTile(
                  title: Text(
                    suggestion,
                    style: TextStyle(
                      backgroundColor: Colors.white,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      textController.text = suggestion;
                      selectedAnak = suggestion;
                      searchSuggestions.clear();
                    });
                  },
                );
              }).toList(),
            ),
          ),
        if (selectedAnak != null) _buildListItem(selectedAnak),
      ],
    );
  }

  Widget _buildListItem(String? selectedAnak) {
    if (selectedAnak == null) {
      return SizedBox
          .shrink(); // Don't display anything if selectedAnak is null
    }

    final anak = anakList.firstWhere(
      (anak) => anak.namaAnak == selectedAnak,
      orElse: () => AnakItem(
        id: 0,
        namaAnak: "Tidak ada Data",
        kelas: "Nama Anak tersebut tidak ada",
        customerId: 0,
        isSelected: false,
        isSwitchOn: false,
      ),
    );

    if (anak.namaAnak == "Tidak ada Data") {
      return ListTile(
        title: Text(
          anak.namaAnak,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          anak.kelas,
        ),
      );
    }

    return ListTile(
      title: Text(
        anak.namaAnak,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        anak.kelas,
      ),
    );
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
                    fontSize:
                        16, // Ubah sesuai dengan ukuran teks yang diinginkan
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 24.0),
                const Divider(
                  thickness: 2,
                ),
                OrderCategoryHeader(
                    title: 'Untuk Seseorang?',
                    icon: Icons.person,
                    iconColor: Colors.black),
                Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, right: 10, left: 10),
                      child: AnimSearchBar(
                        width: 400,
                        textController: textController,
                        onSuffixTap: () {
                          setState(() {
                            textController.clear();
                            searchSuggestions
                                .clear(); // Menghapus saran saat menghapus teks
                          });
                        },
                        onSubmitted: (query) {
                          setState(() {
                            selectedAnak = query;

                            if (selectedAnak == "Tidak ada Data") {
                              searchSuggestions.clear();
                            } else {
                              textController.clear();
                              searchSuggestions.clear();
                            }
                          });
                        },
                      ),
                    ),
                    _buildSelectedOrSuggestionItem(),
                  ],
                ),

                SizedBox(height: 24.0),
                InputField(
                    controller: notesController,
                    hintText: 'Pedas / Tidak Pedas'),
                const Divider(
                  thickness: 2,
                ),
                OrderCategoryHeader(
                    title: 'Mau Tambah Snacks?',
                    icon: Icons.cookie,
                    iconColor: Colors.black),

                SizedBox(height: 8.0),
                Divider(thickness: 1),
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
//                           return SnackListTile(
//                               name: snacks[index].namaSnack,
//                               image: snacks[index].gambar,
//                               description: snacks[index].deskripsi,
//                               harga: snacks[index].harga,
//                               snack: snacks[index], // Tambahkan ini

//                               onSnackAdded: onSnackAdded,
//                               onSnackRemoved: onSnackRemoved,
//                               onSnackSelected: (snack, isSelected) {
//                                 if (mounted) {
//                                   setState(() {
//                                     if (isSelected) {
//                                       selectedSnacks.add(snack);

//                                       // Setel selectedSnackName dengan nama snack yang dipilih
// // Tambahkan snack yang dipilih ke list selectedSnacks
//                                     } else {
//                                       selectedSnacks.remove(
//                                           snack); // Hapus snack yang tidak dipilih dari list selectedSnacks
//                                     }
//                                     print(selectedSnacks);

// // Tambahkan ini untuk memeriksa data snack yang terpilih
//                                   }); // Tambahkan callback ini
//                                 }
//                               });
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
        bottomNavigationBar: ThirdBottomOrderPage(
          totalHarga: totalHarga,
          menuName: widget.menuName,
          menuPrice: widget.price,
          menuDescription: widget.description,
          selectedSnacks: selectedSnacks,
          orderType: widget.orderType,
          selectedAnak: selectedAnak,
          tanggal: widget.tanggal,
          notes: notesController.text,
        ));
  }
}
