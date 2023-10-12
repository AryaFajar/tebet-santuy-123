import 'package:appcatering/screens/home/home.dart';
import 'package:appcatering/tabsorderpage/category_orderpage.dart';
import 'package:appcatering/tabsorderpage/dropdown.dart';
import 'package:appcatering/tabsorderpage/order_bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TabOrderAnda extends StatelessWidget {
  const TabOrderAnda({super.key});

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
                    title: 'Pilih Ruangan',
                    icon: Icons.room,
                    iconColor: Colors.black),
                SizedBox(height: 8.0),
                DropDownRuangan(),
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
                      "Lorem Ipsum has been the industry's standard dummy text ever since"),
                  trailing: Icon(Icons.add),
                ),
                const Divider(
                  thickness: 1,
                ),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundImage:
                        NetworkImage("https://picsum.photos/id/238/200/300"),
                  ),
                  title: const Text(
                    "Mie Ayam",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  subtitle: const Text(
                      "Lorem Ipsum has been the industry's standard dummy text ever since."),
                  trailing: Icon(Icons.add),
                ),
                const Divider(
                  thickness: 1,
                ),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundImage:
                        NetworkImage("https://picsum.photos/id/238/200/300"),
                  ),
                  title: const Text(
                    "Nasi Goreng",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  subtitle: const Text(
                      "Lorem Ipsum has been the industry's standard dummy text ever since."),
                  trailing: Icon(Icons.add),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: bottomOrderpage());
  }
}
