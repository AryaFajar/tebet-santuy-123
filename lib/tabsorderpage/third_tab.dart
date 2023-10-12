import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:appcatering/tabsorderpage/category_orderpage.dart';
import 'package:appcatering/tabsorderpage/order_bottomnavbar.dart';
import 'package:flutter/material.dart';

import 'package:icon_forest/iconoir.dart';

class TabOrderLainnya extends StatefulWidget {
  const TabOrderLainnya({super.key});

  @override
  State<TabOrderLainnya> createState() => _TabOrderLainnyaState();
}

class _TabOrderLainnyaState extends State<TabOrderLainnya> {
  final _controller00 = ValueNotifier<bool>(false);
  static const String fire_flame = 'fire_flame.svg';
  bool isChecked = true;
  bool isSwitchOn = false;
  TextEditingController textController = TextEditingController();
  String? selectedItem; // Variable to hold the selected item.

  List<Map<String, String>> itemList = [
    {
      "title": "Arya Fajar Pratama",
      "subtitle": "KELAS A",
    },
    {
      "title": "Azhar Syarif",
      "subtitle": "KELAS B",
    },
    {
      "title": "Yossy Febrianti",
      "subtitle": "KELAS C",
    },
    // Add more items to your list.
  ];

  List<String> searchSuggestions = [];
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
                        'PAKET NASI GORENG SPESIAL',
                        style: TextStyle(
                          fontSize:
                              24, // Ubah sesuai dengan ukuran teks yang diinginkan
                          fontWeight: FontWeight.bold, // Sesuaikan gaya teks
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      '20K',
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
                  'Deskripsi dari PAKET NASI GORENG SPESIAL akan ditampilkan di sini.',
                  style: TextStyle(
                    fontSize:
                        16, // Ubah sesuai dengan ukuran teks yang diinginkan
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 24.0),

                Text(
                  'Isi Paket',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Nasi Goreng, Chicken Katsu, Yakult, Acar wortel timun.',
                  style: TextStyle(
                    fontSize: 16,
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
                            selectedItem = query;

                            if (selectedItem == "Tidak ada Data") {
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

                SizedBox(height: 10),

                const Divider(
                  thickness: 2,
                ),
                OrderCategoryHeader(
                    title: 'Mau Tambah Snacks?',
                    icon: Icons.cookie,
                    iconColor: Colors.black),

                SizedBox(height: 8.0),
                Divider(thickness: 1),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://picsum.photos/seed/picsum/200/300"),
                  ),
                  title: const Text(
                    "Mie KOCOK",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  subtitle: const Text(
                      "Lorem Ipsum has been the industry's stAnakrd dummy text ever since"),
                  trailing: Icon(Icons.add),
                ),
                const Divider(
                  thickness: 1,
                ),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://picsum.photos/seed/picsum/200/300"),
                  ),
                  title: const Text(
                    "Mie KOCOK",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  subtitle: const Text(
                      "Lorem Ipsum has been the industry's stAnakrd dummy text ever since"),
                  trailing: Icon(Icons.add),
                ),

                const Divider(
                  thickness: 1,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: bottomOrderpage());
  }

  @override
  void initState() {
    super.initState();
    textController.addListener(() {
      updateSearchSuggestions(textController.text);
    });
  }

  void updateSearchSuggestions(String query) {
    setState(() {
      searchSuggestions = itemList
          .where((item) =>
              item['title']!.toLowerCase().contains(query.toLowerCase()))
          .map((item) => item['title']!)
          .toList();

      // if (searchSuggestions.isEmpty && query.isNotEmpty) {
      //   // Hapus saran jika tidak ada data yang cocok dan pengguna menekan "Enter"
      //   textController.clear();
      // }
    });
  }

  Widget _buildSelectedOrSuggestionItem() {
    return Column(
      children: [
        if (searchSuggestions.isNotEmpty)
          Container(
            color: Colors.white, // Atur warna latar belakang
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: searchSuggestions.map((suggestion) {
                return ListTile(
                  title: Text(
                    suggestion,
                    style: TextStyle(
                      backgroundColor:
                          Colors.white, // Atur warna latar belakang teks
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      textController.text = suggestion;
                      selectedItem = suggestion;
                      searchSuggestions
                          .clear(); // Menghapus saran saat item terpilih
                    });
                  },
                );
              }).toList(),
            ),
          ),
        if (selectedItem != null) _buildListItem(selectedItem!),
      ],
    );
  }

  Widget _buildListItem(String selectedItem) {
    final item = itemList.firstWhere(
      (element) => element['title'] == selectedItem,
      orElse: () => {
        "title": "Tidak ada Data",
        "subtitle": "Nama Anak tersebut tidak ada",
        // Anda dapat menyediakan URL gambar default atau biarkan kosong.
      },
    );

    if (item['title'] == "Tidak ada Data") {
      return ListTile(
        title: Text(
          item['title']!,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          item['subtitle']!,
        ),
        // Tidak ada trailing di sini
      );
    }

    return ListTile(
      title: Text(
        item['title']!,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        item['subtitle']!,
      ),
      trailing: isChecked
          ? GestureDetector(
              onTap: () {
                setState(() {
                  isSwitchOn = !isSwitchOn;
                });
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: isSwitchOn ? Colors.red : Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Iconoir(
                    Iconoir.fire_flame,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : null, // Hanya tampilkan AdvancedSwitch jika isChecked adalah true
    );
  }
}

void main() {
  runApp(TabOrderLainnya());
}
