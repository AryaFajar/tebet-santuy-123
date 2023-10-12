import 'package:appcatering/screens/home/home.dart';
import 'package:appcatering/tabsorderpage/category_orderpage.dart';
import 'package:appcatering/tabsorderpage/dropdown.dart';
import 'package:appcatering/tabsorderpage/order_bottomnavbar.dart';
import 'package:appcatering/tabsorderpage/switchflutter.dart';
import 'package:appcatering/tabsorderpage/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:icon_forest/amazingneoicons.dart';
import 'package:icon_forest/icon_forest.dart';
import 'package:icon_forest/flat_icons_medium.dart';
import 'package:icon_forest/iconoir.dart';
import 'package:intl/intl.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class TabOrderAnak extends StatefulWidget {
  const TabOrderAnak({super.key});

  @override
  State<TabOrderAnak> createState() => _TabOrderAnakState();
}

class _TabOrderAnakState extends State<TabOrderAnak> {
  static const String fire_flame = 'fire_flame.svg';
  bool isChecked = false;
  bool isSwitchOn = false;

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
                    title: 'Untuk Ananda?',
                    icon: Icons.child_care,
                    iconColor: Colors.black),
                SizedBox(height: 24.0),

                ListTile(
                  leading: Checkbox(
                    value: isChecked,
                    onChanged: (newValue) {
                      setState(() {
                        isChecked = newValue!;
                        if (!isChecked) {
                          // Jika Checkbox dinonaktifkan, set nilai AdvancedSwitch menjadi false
                          isSwitchOn = false;
                        }
                      });
                    },
                  ),
                  title: Text(
                    '<NAME>',
                    style: TextStyle(
                      color: isChecked
                          ? Colors.black
                          : Colors
                              .grey, // Ubah warna teks sesuai dengan keadaan Checkbox
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    'Kelas C',
                    style: TextStyle(
                      color: isChecked
                          ? Colors.black
                          : Colors
                              .grey, // Ubah warna teks sesuai dengan keadaan Checkbox
                      fontSize: 16,
                    ),
                  ),
                  trailing: isChecked
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              isSwitchOn = !isSwitchOn;
                            });
                          },
                          child: Container(
                            width: 60,
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
                ),

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

                const Divider(
                  thickness: 1,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: bottomOrderpage());
  }
}
